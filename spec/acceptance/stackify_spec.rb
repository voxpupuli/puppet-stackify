require 'spec_helper_acceptance'

describe 'stackify' do
  # EXAMPLE stackify.ini
  # [License]
  # ActivationKey=XXXXXXXXXXXXXXXXXXXXXXXXXX
  #
  # [Feature]
  # EnableRemoteAccess=0
  # RestartIIS=0
  # EnableProfiler=1
  # IPMask=0
  # x86=
  # ProfilerStarted=1
  # AttachAll=1
  #
  # [Environment]
  # EnvironmentID=12
  # DeviceAlias=
  # Environment=real-prod
  #
  # [Status]
  # AgentStarted=2017-03-16T03:04:33.9593056Z
  # APMPosition=1490641306
  #
  # [Device]
  # DeviceID=101

  let(:activation_key) { 'XXXXXXXXXXXXXXXXXXXXXXXXXX' }
  let(:environment) { 'development' }

  context 'when installing with provided mandatory parameters' do
    let(:install_manifest) do
      <<-MANIFEST
          class { 'stackify':
              package_ensure                        => 'present',
              package_install_options_environment   => '#{environment}',
              package_install_options_activationkey => '#{activation_key}',
          }
        MANIFEST
    end

    it 'runs without errors' do
      apply_manifest(install_manifest, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(install_manifest, catch_changes: true)
    end

    describe package('StackifyAgentProd') do
      it { is_expected.to be_installed }
    end

    describe service('StackifyHealthService') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_installed }
      it { is_expected.to be_running }
    end

    describe service('StackifyMonitoringService') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_installed }
      it { is_expected.to be_running }
    end

    describe file('C:\Program Files (x86)\Stackify') do
      it { is_expected.to exist }
      it { is_expected.to be_directory }
    end

    describe file('C:\Program Files (x86)\Stackify\Stackify.ini') do
      its(:content) { is_expected.to match %r{ActivationKey=#{activation_key}} }
      its(:content) { is_expected.to match %r{DeviceAlias=#{fact('hostname')}} }
      its(:content) { is_expected.to match %r{Environment=#{environment}} }
      its(:content) { is_expected.to match %r{EnableProfiler=1} }
      its(:content) { is_expected.to match %r{IPMask=0} }
      its(:content) { is_expected.to match %r{AttachAll=1} }
    end

    describe file('C:\Binaries') do
      it { is_expected.to exist }
      it { is_expected.to be_directory }
    end

    describe file('C:\Binaries\Stackify-Install-Latest.exe') do
      it { is_expected.to exist }
      it { is_expected.to be_file }
    end
  end

  context 'when uninstalling with provided mandatory parameters' do
    let(:uninstall_manifest) do
      <<-MANIFEST
          class { 'stackify':
              package_ensure                        => 'absent',
              package_install_options_environment   => 'development',
              package_install_options_activationkey => 'XXXXXXXXXXXXXXXXXXXXXXXXXX',
          }
        MANIFEST
    end

    it 'runs without errors' do
      apply_manifest(uninstall_manifest, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(uninstall_manifest, catch_changes: true)
    end

    describe package('StackifyAgentProd') do
      it { is_expected.not_to be_installed }
    end

    describe service('StackifyHealthService') do
      it { is_expected.not_to be_installed }
    end

    describe service('StackifyMonitoringService') do
      it { is_expected.not_to be_installed }
    end

    describe file('C:\Binaries') do
      it { is_expected.to exist }
      it { is_expected.to be_directory }
    end
    # TODO: We should remove the binary after install
    # describe file('C:\Binaries\Stackify-Install-Latest.exe') do
    #    it { should_not exist }
    # end
  end
end

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
  before(:all) do
    @activation_key = 'XXXXXXXXXXXXXXXXXXXXXXXXXX'
    @environment    = 'development'
  end

  context 'when installing with provided mandatory parameters' do
    let(:install_manifest) {
      <<-MANIFEST
          class { 'stackify':
              package_ensure                        => 'present',
              package_install_options_environment   => '#{@environment}',
              package_install_options_activationkey => '#{@activation_key}',
          }
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(install_manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(install_manifest, :catch_changes => true)
    end

    describe package('StackifyAgentProd') do
      it { should be_installed }
    end

    describe service('StackifyHealthService') do
      it { should be_enabled }
      it { should be_installed }
      it { should be_running }
    end

    describe service('StackifyMonitoringService') do
      it { should be_enabled }
      it { should be_installed }
      it { should be_running }
    end

    describe file('C:\Program Files (x86)\Stackify') do
       it { should exist }
       it { should be_directory }
    end

    describe file('C:\Program Files (x86)\Stackify\Stackify.ini') do
       its (:content) { should match /ActivationKey=#{@activation_key}/ }
       its (:content) { should match /DeviceAlias=#{fact('hostname')}/ }
       its (:content) { should match /Environment=#{@environment}/ }
       its (:content) { should match /EnableProfiler=1/ }
       its (:content) { should match /IPMask=0/ }
       its (:content) { should match /AttachAll=1/ }
    end

    describe file('C:\Binaries') do
       it { should exist }
       it { should be_directory }
    end

    describe file('C:\Binaries\Stackify-Install-Latest.exe') do
       it { should exist }
       it { should be_file }
    end

  end

  context 'when uninstalling with provided mandatory parameters' do
    let(:uninstall_manifest) {
      <<-MANIFEST
          class { 'stackify':
              package_ensure                        => 'absent',
              package_install_options_environment   => 'development',
              package_install_options_activationkey => 'XXXXXXXXXXXXXXXXXXXXXXXXXX',
          }
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(uninstall_manifest, :catch_failures => true)
    end

    it "should be idempotent" do
      apply_manifest(uninstall_manifest, :catch_changes => true)
    end

    describe package('StackifyAgentProd') do
      it { should_not be_installed }
    end

    describe service('StackifyHealthService') do
      it { should_not be_installed }
    end

    describe service('StackifyMonitoringService') do
      it { should_not be_installed }
    end

    describe file('C:\Binaries') do
       it { should exist }
       it { should be_directory }
    end
    # TODO: We should remove the binary after install
    # describe file('C:\Binaries\Stackify-Install-Latest.exe') do
    #    it { should_not exist }
    # end

  end

end

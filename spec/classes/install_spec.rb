require 'spec_helper'

describe 'stackify::install' do
  context 'when package_ensure => present' do
    let(:facts) do
      {
        networking: { hostname: 'DESKTOP-AT3' }
      }
    end
    let(:params) do
      {
        package_install_options_environment: 'qa3',
        package_install_options_activationkey: 'SomeSecretKey'
      }
    end

    it do
      is_expected.to contain_package('StackifyAgentProd').with('ensure' => 'present',
                                                               'install_options' => [
                                                                 '/s',
                                                                 '/v"ACTIVATIONKEY=SomeSecretKey',
                                                                 'ENVIRONMENT="qa3"',
                                                                 'DEVICEALIAS="DESKTOP-AT3"',
                                                                 'IPMASK=0',
                                                                 'ENABLEPROFILER=1',
                                                                 'ENABLEREMOTE=True',
                                                                 'RESTARTIIS=0',
                                                                 'ATTACHALL=1',
                                                                 '/qn',
                                                                 '/l*v',
                                                                 'C:\StackifyInstallLog.txt"'
                                                               ])
    end

    it do
      is_expected.to contain_file('C:\\Binaries').with('ensure' => 'directory')
    end

    it do
      is_expected.to contain_file('C:\\Binaries\\Stackify-Install-Latest.exe').with('ensure' => 'file',
                                                                                    'source'  => 'http://s1.stackify.com/Account/AgentDownload',
                                                                                    'require' => 'File[C:\\Binaries]')
    end
  end

  context 'when package_install_options_attach_all => false' do
    let(:facts) do
      {
        networking: { hostname: 'DESKTOP-AT3' }
      }
    end
    let(:params) do
      {
        package_install_options_environment: 'qa3',
        package_install_options_activationkey: 'SomeSecretKey',
        package_install_options_attach_all: false
      }
    end

    it do
      is_expected.to contain_package('StackifyAgentProd').with('ensure' => 'present',
                                                               'install_options' => [
                                                                 '/s',
                                                                 '/v"ACTIVATIONKEY=SomeSecretKey',
                                                                 'ENVIRONMENT="qa3"',
                                                                 'DEVICEALIAS="DESKTOP-AT3"',
                                                                 'IPMASK=0',
                                                                 'ENABLEPROFILER=1',
                                                                 'ENABLEREMOTE=True',
                                                                 'RESTARTIIS=0',
                                                                 'ATTACHALL=0',
                                                                 '/qn',
                                                                 '/l*v',
                                                                 'C:\StackifyInstallLog.txt"'
                                                               ])
    end
  end

  context 'when package_install_options_enable_profiler => false' do
    let(:facts) do
      {
        networking: { hostname: 'DESKTOP-AT3' }
      }
    end
    let(:params) do
      {
        package_install_options_environment: 'qa3',
        package_install_options_activationkey: 'SomeSecretKey',
        package_install_options_enable_profiler: false
      }
    end

    it do
      is_expected.to contain_package('StackifyAgentProd').with('ensure' => 'present',
                                                               'install_options' => [
                                                                 '/s',
                                                                 '/v"ACTIVATIONKEY=SomeSecretKey',
                                                                 'ENVIRONMENT="qa3"',
                                                                 'DEVICEALIAS="DESKTOP-AT3"',
                                                                 'IPMASK=0',
                                                                 'ENABLEPROFILER=0',
                                                                 'ENABLEREMOTE=True',
                                                                 'RESTARTIIS=0',
                                                                 'ATTACHALL=1',
                                                                 '/qn',
                                                                 '/l*v',
                                                                 'C:\StackifyInstallLog.txt"'
                                                               ])
    end
  end

  context 'when package_install_options_enable_ipmask => false' do
    let(:facts) do
      {
        networking: { hostname: 'DESKTOP-AT3' }
      }
    end
    let(:params) do
      {
        package_install_options_environment: 'qa3',
        package_install_options_activationkey: 'SomeSecretKey',
        package_install_options_enable_ipmask: true
      }
    end

    it do
      is_expected.to contain_package('StackifyAgentProd').with('ensure' => 'present',
                                                               'install_options' => [
                                                                 '/s',
                                                                 '/v"ACTIVATIONKEY=SomeSecretKey',
                                                                 'ENVIRONMENT="qa3"',
                                                                 'DEVICEALIAS="DESKTOP-AT3"',
                                                                 'IPMASK=1',
                                                                 'ENABLEPROFILER=1',
                                                                 'ENABLEREMOTE=True',
                                                                 'RESTARTIIS=0',
                                                                 'ATTACHALL=1',
                                                                 '/qn',
                                                                 '/l*v',
                                                                 'C:\StackifyInstallLog.txt"'
                                                               ])
    end
  end
end

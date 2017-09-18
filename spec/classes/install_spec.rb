require 'spec_helper'

describe 'stackify::install' do

  context 'when package_ensure => present' do
    let(:facts) { {
      :hostname => 'DESKTOP-AT3',
    } }
    let(:params) {
      {
        :package_install_options_environment => 'qa3',
        :package_install_options_activationkey => 'SomeSecretKey',
      }
    }
    it do
      should contain_package('StackifyAgentProd').with({
      'ensure'          => 'present',
      'install_options' => [
          '/s',
          '/v"ACTIVATIONKEY=SomeSecretKey',
          "ENVIRONMENT=\"qa3\"",
          "DEVICEALIAS=\"DESKTOP-AT3\"",
          'IPMASK=0',
          'ENABLEPROFILER=1',
          'ENABLEREMOTE=True',
          'RESTARTIIS=0',
          'ATTACHALL=1',
          '/qn' ,
          '/l*v',
          'C:\StackifyInstallLog.txt"', ],
      })
    end

    it do
      should contain_file('C:\\Binaries').with({
        'ensure' => 'directory',
        })
    end

    it do
      should contain_file('C:\\Binaries\\Stackify-Install-Latest.exe').with({
        'ensure'  => 'present',
        'source'  => 'http://s1.stackify.com/Account/AgentDownload',
        'require' => 'File[C:\\Binaries]',
        })
    end

    it { is_expected.to  compile.with_all_deps }
  end

  context 'when package_install_options_environment => ""' do
    let(:params) {
      {
        :package_install_options_environment => '',
        :package_install_options_activationkey => 'SomeSecretKey',
      }
    }
    it { should compile.and_raise_error(/The Environment variable was not provided\.  This is a required parameter\./) }
  end


  context 'when package_install_options_attach_all => false' do
    let(:facts) { {
      :hostname => 'DESKTOP-AT3',
    } }
    let(:params) {
      {
        :package_install_options_environment   => 'qa3',
        :package_install_options_activationkey => 'SomeSecretKey',
        :package_install_options_attach_all    => false,
      }
    }

    it do
      should contain_package('StackifyAgentProd').with({
      'ensure'          => 'present',
      'install_options' => [
          '/s',
          '/v"ACTIVATIONKEY=SomeSecretKey',
          "ENVIRONMENT=\"qa3\"",
          "DEVICEALIAS=\"DESKTOP-AT3\"",
          'IPMASK=0',
          'ENABLEPROFILER=1',
          'ENABLEREMOTE=True',
          'RESTARTIIS=0',
          'ATTACHALL=0',
          '/qn' ,
          '/l*v',
          'C:\StackifyInstallLog.txt"', ],
      })
    end
  end

    context 'when package_install_options_enable_profiler => false' do
      let(:facts) { {
        :hostname => 'DESKTOP-AT3',
      } }
      let(:params) {
        {
          :package_install_options_environment     => 'qa3',
          :package_install_options_activationkey   => 'SomeSecretKey',
          :package_install_options_enable_profiler => false,
        }
      }

      it do
        should contain_package('StackifyAgentProd').with({
        'ensure'          => 'present',
        'install_options' => [
            '/s',
            '/v"ACTIVATIONKEY=SomeSecretKey',
            "ENVIRONMENT=\"qa3\"",
            "DEVICEALIAS=\"DESKTOP-AT3\"",
            'IPMASK=0',
            'ENABLEPROFILER=0',
            'ENABLEREMOTE=True',
            'RESTARTIIS=0',
            'ATTACHALL=1',
            '/qn' ,
            '/l*v',
            'C:\StackifyInstallLog.txt"', ],
        })
      end

  end

  context 'when package_install_options_enable_ipmask => false' do
    let(:facts) { {
      :hostname => 'DESKTOP-AT3',
    } }
    let(:params) {
      {
        :package_install_options_environment     => 'qa3',
        :package_install_options_activationkey   => 'SomeSecretKey',
        :package_install_options_enable_ipmask   => true,
      }
    }

    it do
      should contain_package('StackifyAgentProd').with({
      'ensure'          => 'present',
      'install_options' => [
          '/s',
          '/v"ACTIVATIONKEY=SomeSecretKey',
          "ENVIRONMENT=\"qa3\"",
          "DEVICEALIAS=\"DESKTOP-AT3\"",
          'IPMASK=1',
          'ENABLEPROFILER=1',
          'ENABLEREMOTE=True',
          'RESTARTIIS=0',
          'ATTACHALL=1',
          '/qn' ,
          '/l*v',
          'C:\StackifyInstallLog.txt"', ],
      })
    end

end

end

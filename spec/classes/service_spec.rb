require 'spec_helper'

describe 'stackify::service' do

  context 'when service_ensure => dinosaur' do
    let(:params) {{ :service_ensure => 'dinosaur' }}
    it { should compile.and_raise_error(/service_ensure parameter must be running or stopped/) }
  end

  context 'when service_manage => false' do
    let(:params) {{ :service_manage => false }}
    it do
      is_expected.not_to contain_service('StackifyMonitoringService')
    end

    it do
      is_expected.not_to contain_service('StackifyHealthService')
    end
  end

  context 'when service_manage => true and service_enable => true' do
    let(:params) {
      {
        :service_manage => true,
        :service_enable => true
      }
    }
    it do
      is_expected.to contain_service('StackifyMonitoringService').with({
        'ensure'     => 'running',
        'enable'     => true,
      })
    end

    it do
      is_expected.to contain_service('StackifyHealthService').with({
        'ensure'     => 'running',
        'enable'     => true,
      })
    end
  end

  context 'when service_manage => true and service_ensure => stopped and service_enable => false' do
    let(:params) do
     {
       'service_manage' => true,
       'service_ensure' => 'stopped',
       'service_enable' => false,
     }
   end
    it do
      is_expected.to contain_service('StackifyMonitoringService').with({
        'enable'         => 'false',
        'ensure'         => 'stopped',
      })
    end

    it do
      is_expected.to contain_service('StackifyHealthService').with({
        'enable'         => 'false',
        'ensure'         => 'stopped',
      })
    end
  end

  context 'when service_manage => true and service_ensure => running' do
    let(:params) do
     {
       'service_manage' => true,
       'service_ensure' => 'running',
     }
   end
    it do
      is_expected.to contain_service('StackifyMonitoringService').with({
        'ensure'     => 'running',
      })
    end

    it do
      is_expected.to contain_service('StackifyHealthService').with({
        'ensure'     => 'running',
      })
    end
  end

end

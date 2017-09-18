require 'spec_helper'
describe 'stackify' do
  context 'with default values for all parameters' do
    let(:params) do
      {
        package_install_options_environment: 'qa3',
        package_install_options_activationkey: 'SomeSecretKey',
      }
    end

    it { is_expected.to contain_class('stackify::install') }
    it { is_expected.to contain_class('stackify::service').that_requires('Class[stackify::install]') }
  end
end

require 'spec_helper'
describe 'stackify' do

  context 'with default values for all parameters' do
    let(:params) {
      {
        :package_install_options_environment => 'qa3',
        :package_install_options_activationkey => 'SomeSecretKey',
      }
    }
    it { should contain_class('stackify::install') }
    it { should contain_class('stackify::service').that_requires('Class[stackify::install]') }
  end

end

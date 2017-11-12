require 'spec_helper'

describe 'stackify::params' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('stackify::params') }

    # This is a params class....
    it { is_expected.to have_resource_count(0) }
  end
end

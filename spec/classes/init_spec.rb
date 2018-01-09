require 'spec_helper'
describe 'environmentrefresh' do
  context 'with default values for all parameters' do
    it { should contain_class('environmentrefresh') }
  end
end

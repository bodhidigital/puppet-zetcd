require 'spec_helper'
describe 'zetcd' do
  context 'with default values for all parameters' do
    it { should contain_class('zetcd') }
  end
end

require 'spec_helper'
describe 'users' do

  context 'with defaults for all parameters' do
    it { should contain_class('users') }
  end
end

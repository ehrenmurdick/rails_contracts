require 'rails_helper'

RSpec.describe 'topic routing' do
  context 'index' do
    Contract.create('TopicsController#index')
    it { expect(get: '/topics').to route_to('topics#index') }
  end
end

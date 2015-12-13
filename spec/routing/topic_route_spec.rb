require 'rails_helper'

RSpec.describe 'topic routing' do
  context 'index' do
    Contract.create('TopicsController#index')
    it { expect(get: '/topics').to route_to('topics#index') }
  end

  context 'show' do
    Contract.create('TopicsController#show')
    it do
      expect(get: '/topics/1').
        to route_to(controller: 'topics', action: 'show', id: '1')
    end
  end

  context 'edit' do
    Contract.create('TopicsController#edit')
    it do
      expect(get: '/topics/1/edit').
        to route_to(controller: 'topics', action: 'edit', id: '1')
    end
  end

  context 'create' do
    Contract.create('TopicsController#edit')
    it do
      expect(post: '/topics').
        to route_to(controller: 'topics', action: 'create')
    end
  end

  context 'update' do
    Contract.create('TopicsController#update')
    it do
      expect(put: '/topics/1').
        to route_to(controller: 'topics', action: 'update', id: '1')
    end
  end

  context 'destroy' do
    Contract.create('TopicsController#destroy')
    it do
      expect(delete: '/topics/1').
        to route_to(controller: 'topics', action: 'destroy', id: '1')
    end
  end
end

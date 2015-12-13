require 'rails_helper'

describe TopicsController do
  describe 'get :index' do
    before do
      Contract.fulfill("TopicsController#index")
      get :index
    end

    it { expect(response.status).to eql(200) }
  end
end

require 'rails_helper'

describe TopicsController do
  let(:topic) { Object.new }
  let(:topics) { [topic] }

  let(:model) { double(:Topic) }

  describe 'actions' do
    before do
      Contract.create('TopicsController.model Topic')
      allow(controller).to receive(:model).and_return(model)
    end

    describe 'get :index' do
      before do
        Contract.create('Topic.all [topic]')
        expect(model).to receive(:all).and_return(topics)

        Contract.fulfill("TopicsController#index")
        get :index
      end

      it { expect(response.status).to eql(200) }
      Contract.fulfill('TopicsController assigns @topics')
      it { expect(assigns[:topics]).to eql(topics) }
    end
  end

  describe '.model' do
    Contract.fulfill('TopicsController.model Topic')
    it { expect(controller.model).to eql(Topic) }
  end
end

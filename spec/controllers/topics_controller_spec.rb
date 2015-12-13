require 'rails_helper'

describe TopicsController do
  Contract.create('Topic#to_param "1"')
  let(:topic) { double(:topic, to_param: '1') }

  let(:topics) { [topic] }

  let(:model) { double(:Topic) }

  describe 'actions' do
    before do
      Contract.create('TopicsController.model Topic')
      allow(controller).to receive(:model).and_return(model)
    end

    shared_examples 'topic not found' do
      describe 'not found' do
        before do
          Contract.create('Topic.find("1") ! ActiveRecord::RecordNotFound')
          expect(model).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)
          do_request
        end
        it { expect(response.status).to eql(404) }
      end
    end

    shared_examples 'found' do
      before do
        Contract.create('Topic.find("1") topic')
        expect(model).to receive(:find).with("1").and_return(topic)
      end
    end

    describe 'get :index' do
      before do
        Contract.create('Topic.all [topic]')
        expect(model).to receive(:all).and_return(topics)

        Contract.fulfill("TopicsController#index")
        get :index
      end

      it { expect(response.status).to eql(200) }
      Contract.fulfill('TopicsController#index assigns @topics')
      it { expect(assigns[:topics]).to eql(topics) }
    end

    describe 'get :show' do
      let(:do_request) { get :show, id: 1 }
      it_behaves_like 'topic not found'

      context 'found' do
        include_examples 'found'
        before do
          Contract.fulfill('TopicsController#show')
          do_request
        end

        it { expect(response.status).to eql(200) }
        Contract.fulfill('TopicsController#show assigns @topic')
        it { expect(assigns[:topic]).to eql(topic) }
      end
    end

    describe 'get :edit' do
      it_behaves_like 'topic not found'
      let(:do_request) { get :edit, id: 1 }

      context 'found' do
        include_examples 'found'
        before do
          Contract.fulfill('TopicsController#edit')
          do_request
        end

        it { expect(response.status).to eql(200) }
        Contract.fulfill('TopicsController#edit assigns @topic')
        it { expect(assigns[:topic]).to eql(topic) }
      end
    end

    describe 'put :update' do
      Contract.fulfill('TopicsController#update')
      let(:do_request) do
        put :update, id: 1, topic: { name: 'foo' }
      end

      it_behaves_like 'topic not found'
      context 'found' do
        include_examples 'found'

        describe 'update successful' do
          before do
            Contract.create('Topic#update_attributes true')
            expect(topic).to receive(:update_attributes).with('name' => 'foo').and_return(true)
            do_request
          end

          Contract.create('TopicsController#show')
          it { expect(response.status).to redirect_to('/topics/1') }
        end

        describe 'update unsuccessful' do
          before do
            Contract.create('Topic#update_attributes false')
            expect(topic).to receive(:update_attributes).with('name' => 'foo').and_return(false)
            do_request
          end

          Contract.create('TopicsController#edit')
          it { expect(response.status).to render_template(:edit) }
        end
      end
    end
  end

  describe '.model' do
    Contract.fulfill('TopicsController.model Topic')
    it { expect(controller.model).to eql(Topic) }
  end
end

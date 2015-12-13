require 'rails_helper'

describe 'topics/index.html.haml' do
  Contract.create('Topic#name ""')
  Contract.create('Topic#to_param "1"')
  let(:topic) { double(:topic, name: 'A Topic', to_param: '1') }
  let(:topics) { [topic] }

  before do
   Contract.create('TopicsController#index assigns @topics')
    assign(:topics, topics)
    render
  end

  it { expect(rendered).to include('A Topic') }
  it { expect(rendered).to include('href="/topics/1"') }
end

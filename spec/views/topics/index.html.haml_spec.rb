require 'rails_helper'

describe 'topics/index.html.haml' do
  Contract.create('Topic#name ""')
  let(:topic) { double(:topic, name: 'A Topic') }
  let(:topics) { [topic] }

  before do
   Contract.create('TopicsController assigns @topics')
    assign(:topics, topics)
    render
  end

  it { expect(rendered).to include('A Topic') }
end

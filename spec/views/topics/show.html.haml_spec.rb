require 'rails_helper'

describe 'topics/show.html.haml' do
  let(:topic) { double(:topic) }
  before do
    Contract.create('TopicsController#show assigns @topic')
    assign(:topic, topic)

    Contract.create('Topic#name ""')
    expect(topic).to receive(:name).and_return('A name')
    render
  end

  it { expect(rendered).to include('A name') }
end

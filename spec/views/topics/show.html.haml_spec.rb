require 'rails_helper'

describe 'topics/show.html.haml' do
  Contract.create('Topic#name ""')
  Contract.create('Topic#to_param "1"')
  let(:topic) { double(:topic, to_param: '1', name: 'A name') }

  before do
    Contract.create('TopicsController#show assigns @topic')
    assign(:topic, topic)
    render
  end

  it { expect(rendered).to include('A name') }

  Contract.create('TopicsController#edit')
  it { expect(css_select('a[href="/topics/1/edit"]')).to_not be_empty }

  Contract.create('TopicsController#destroy')
  it { expect(css_select('a[data-method="delete"][href="/topics/1"]')).to_not be_empty }

  Contract.create('TopicsController#index')
  it { expect(css_select('a[href="/topics"]')).to_not be_empty }
end

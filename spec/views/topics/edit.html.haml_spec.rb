require 'rails_helper'

describe 'topics/edit.html.haml' do
  let(:topic) { double(:topic) }
  before do
    Contract.create('TopicsController#edit assigns @topic')
    assign(:topic, topic)

    Contract.create('Topic#name ""')
    expect(topic).to receive(:name).and_return('A name')

    Contract.create('Topic#model_name Topic.model_name')
    expect(topic).to receive(:model_name).
      at_least(:once).
      and_return(Topic.model_name)

    Contract.create('Topic#to_key [1]')
    expect(topic).to receive(:to_key).
      and_return([1])

    Contract.create('Topic#to_model topic')
    expect(topic).to receive(:to_model).
      at_least(:once).
      and_return(topic)

    Contract.create('Topic#persisted? true')
    expect(topic).to receive(:persisted?).
      at_least(:once).
      and_return(true)

    render
  end

  it { expect(rendered).to include('A name') }
end

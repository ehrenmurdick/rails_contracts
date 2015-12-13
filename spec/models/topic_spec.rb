require 'rails_helper'

describe Topic do
  fixtures(:topics)

  let(:first) { topics(:first) }

  describe '.all' do
    Contract.fulfill("Topic.all [topic]")
    it { expect(Topic.all.count).to eql(5) }
  end

  describe '.find' do
    Contract.fulfill('Topic.find("1") topic')
    it { expect(Topic.find(first.id).name).to eql(first.name) }

    Contract.fulfill('Topic.find("1") ! ActiveRecord::RecordNotFound')
    it { expect { Topic.find(99999) }.to raise_error(ActiveRecord::RecordNotFound) }
  end

  describe '#name' do
    Contract.fulfill('Topic#name ""')
    it { expect(first.name).to eql('first topic') }
  end

  describe '#update_attributes' do
    Contract.fulfill('Topic#update_attributes true')
    it { expect(first.update_attributes(name: 'foo')).to be_truthy }
  end

  describe '#destroy' do
    Contract.fulfill('Topic#destroy')
    it { expect { first.destroy }.to_not raise_error }
  end

  describe '#to_param' do
    Contract.fulfill('Topic#to_param "1"')
    it { expect(first.to_param).to eql('309456473') }
  end
end

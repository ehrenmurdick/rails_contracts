require 'rails_helper'

describe Topic do
  fixtures(:topics)

  describe '.all' do
    Contract.fulfill("Topic.all [topic]")
    it { expect(Topic.all.count).to eql(5) }
  end

  describe '#name' do
    Contract.fulfill('Topic#name ""')
    it { expect(topics(:first).name).to eql('first topic') }
  end
end

require 'rails_helper'

describe Topic do
  describe '.all' do
    fixtures(:topics)

    Contract.fulfill("Topic.all [topic]")
    it { expect(Topic.all.count).to eql(5) }
  end
end

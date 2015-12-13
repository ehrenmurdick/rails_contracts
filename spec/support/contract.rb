class Contract
  @created = {}
  @fullfilled = {}

  def self.create argument
    @created[argument] = caller[0]
  end

  def self.fulfill argument
    @fullfilled[argument] = caller[0]
  end

  def self.created_set
    Set.new(@created.keys)
  end

  def self.fullfilled_set
    Set.new(@fullfilled.keys)
  end

  def self.unmatched_created
    unmatched_keys.intersection(created_set)
  end

  def self.unmatched_fulfilled
    unmatched_keys.intersection(fullfilled_set)
  end

  def self.unmatched_keys
    created_set ^ fullfilled_set
  end

  def self.validate
    unmatched_keys.empty?
  end

  def self.messages
    messages = []
    unmatched_created.map do |item|
      messages << "Contract.create(#{item})"
      messages << "   at #{@created[item]}"
    end

    unmatched_fulfilled.map do |item|
      messages << "Contract.fulfill(#{item})"
      messages << "   at #{@fullfilled[item]}"
    end
    messages
  end
end

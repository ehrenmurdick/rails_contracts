module Contract
  extend self
  @created = {}
  @fullfilled = {}

  def create argument
    @created[argument] = caller[0]
  end

  def fulfill argument
    @fullfilled[argument] = caller[0]
  end

  def created_set
    Set.new(@created.keys)
  end

  def fullfilled_set
    Set.new(@fullfilled.keys)
  end

  def unmatched_created
    unmatched_keys.intersection(created_set)
  end

  def unmatched_fulfilled
    unmatched_keys.intersection(fullfilled_set)
  end

  def unmatched_keys
    created_set ^ fullfilled_set
  end

  def validate
    unmatched_keys.empty?
  end

  def truncate path
    path.sub(Rails.root.to_s+'/', '').split(':')[0,2].join(':')
  end

  def messages
    messages = []
    unmatched_created.map do |item|
      messages << "Contract.create(#{item.inspect})"
      messages << "   at #{truncate @created[item]}"
    end

    unmatched_fulfilled.map do |item|
      messages << "Contract.fulfill(#{item.inspect})"
      messages << "   at #{truncate @fullfilled[item]}"
    end
    messages
  end
end

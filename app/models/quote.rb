class Quote
  attr_accessor :quote, :author
  def full_quote
    "#{quote}, #{author}"
  end
end

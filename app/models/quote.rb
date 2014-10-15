class Quote
  attr_reader :quote, :author
  def initialize(quote, author)
    @quote = quote
    @author = author
  end
end

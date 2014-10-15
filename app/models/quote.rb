class Quote
  attr_accessor :quote, :author
  def initialize
    def full_quote
      "#{quote}, #{author}"
    end
  end
end

class Faq
  @@allfaq = Array.new
  def self.all
    @@allfaq
  end

  attr_reader :question, :answer
  def slug
    question.downcase.gsub(/\W+/, '')
  end

  def initialize(question=nil, answer=nil)
    @question = question
    @answer = answer
    @@allfaq << self
  end

end

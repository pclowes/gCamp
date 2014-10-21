class Faq
  attr_reader :question, :answer
  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def self.all
    [
      Faq.new(CONFIG[:what][:question],CONFIG[:what][:answer]),
      Faq.new(CONFIG[:how][:question],CONFIG[:how][:answer]),
      Faq.new(CONFIG[:when1][:question],CONFIG[:when1][:answer]),
      Faq.new(CONFIG[:scared][:question],CONFIG[:scared][:answer]),
      Faq.new(CONFIG[:alternatives][:question],CONFIG[:alternatives][:answer])
    ]
  end

  def slug
    question.downcase.gsub(/\W+/, '')
  end

  include Comparable
  def <=> other
    self.question <=> other.question
  end
end

class Faq
  @@allfaq = Array.new
  def self.all
    @@allfaq
  end

  attr_reader :question, :answer
  def slug
    question.downcase.gsub(/\W+/, '')
  end

  def initialize(question, answer)
    @question = question
    @answer = answer
    @@allfaq << self
  end

Faq.new(CONFIG[:what][:question],CONFIG[:what][:answer])
Faq.new(CONFIG[:how][:question],CONFIG[:how][:answer])
Faq.new(CONFIG[:when1][:question],CONFIG[:when1][:answer])
Faq.new(CONFIG[:scared][:question],CONFIG[:scared][:answer])
Faq.new(CONFIG[:alternatives][:question],CONFIG[:alternatives][:answer])

end

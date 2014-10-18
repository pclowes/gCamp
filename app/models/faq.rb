class Faq
  @@allfaq = Array.new
  def self.all
    @@allfaq
  end

  attr_reader :question, :answer
  def slug
    question.downcase.gsub(/\W+/, '')
  end

  def read_faqs
    faqs = YAML.load_file("faqs.yaml")
    Faq.new=faqs["what"]["question"]
  end

  def initialize(question, answer)
    @question = question
    @answer = answer
    @@allfaq << self
  end
end

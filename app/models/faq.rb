class Faq
  def self.all
    attr_reader :question, :answer
    @allfaq = Array.new

    def initialize(question, answer)
      @question = question
      @answer = answer
      @allfaq << self
    end

    def slug
      question.downcase.gsub(/\W+/, '')
    end

    include Comparable
    def <=> other
      self.question <=> other.question
    end


  end

  Faq.new(CONFIG[:what][:question],CONFIG[:what][:answer]).slug
  Faq.new(CONFIG[:how][:question],CONFIG[:how][:answer]).slug
  Faq.new(CONFIG[:when1][:question],CONFIG[:when1][:answer]).slug
  Faq.new(CONFIG[:scared][:question],CONFIG[:scared][:answer]).slug
  Faq.new(CONFIG[:alternatives][:question],CONFIG[:alternatives][:answer]).slug
  
end

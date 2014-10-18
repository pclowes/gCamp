ENV.update YAML.load(File.read('config/faqs.yml'))[Rails.env] rescue {}
class FaqController < ApplicationController
  def faq
    def read_faqs
      faqs = YAML.load_file("faqs.yaml")
      Faq.new = faqs["what"]["question"]
      how = Faq.new()
      when1 = Faq.new()
      scared = Faq.new()
      alternatives = Faq.new()
    end

  @faqs=Faq.all

  render :faq
  Faq.all.clear
  end
  def read_faqs
    faqs = YAML.load_file("faqs.yaml")
    @what = puts ENV['what']['question']
  end
end

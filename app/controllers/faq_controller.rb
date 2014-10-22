require_relative '../../config/initializers/load_config'
class FaqController < ApplicationController
  def faq
    @faqsort = Faq.all.sort
  render :faq
  end
end

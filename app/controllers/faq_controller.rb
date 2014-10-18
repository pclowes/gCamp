require_relative '../../config/initializers/load_config'
class FaqController < ApplicationController
  def faq
  @faqs=Faq.all
  render :faq
  end
end

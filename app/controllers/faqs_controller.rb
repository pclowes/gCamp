class FaqsController < ApplicationController
  def index
    @faqs = Faq.all
  end

  def show
  end
end

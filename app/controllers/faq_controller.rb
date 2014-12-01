require_relative '../../config/initializers/load_config'
class FaqController < MarketingController
  def faq
    @faqsort = Faq.all.sort
  render :faq
  end
end

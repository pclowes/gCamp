class QuotesController < MarketingController
  def index
    @quotes = Quote.all
  end
end

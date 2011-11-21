class PagesController < ActionController::Base
  protect_from_forgery
  respond_to :html
  layout 'no_sidebar'
  skip_before_filter :authenticate_user!
  caches_page :faq, :features

  def homepage
    if user_signed_in?
      redirect_to user_root_url
    end
  end

  def faq
  end

  def features
  end

end

class PagesController < ActionController::Base
  protect_from_forgery
  respond_to :html
  layout 'no_sidebar'

  def homepage
    if user_signed_in?
      redirect_to user_root_url
    end
  end

end

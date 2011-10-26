class PagesController < ApplicationController
  respond_to :html
  layout 'no_sidebar'
  skip_before_filter :authenticate_user!

  def index
    if user_signed_in?
      redirect_to user_root_url
    end
  end

end

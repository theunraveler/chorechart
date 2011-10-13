class PagesController < ApplicationController
  respond_to :html
  layout 'no_sidebar'

  def index
    if user_signed_in?
      redirect_to user_root_url
    end
  end

end

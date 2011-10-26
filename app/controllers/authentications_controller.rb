class AuthenticationsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :create
  skip_before_filter :authenticate_user!, :only => :create
  respond_to :html

  def index
    @providers = @authentications.collect { |a| a.provider }
    respond_with @authentications
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'].to_s)  
    if authentication
      flash[:notice] = I18n.t "devise.sessions.signed_in"
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user  
      current_user.apply_omniauth(omniauth).save!
      flash[:notice] = "Authentication successfully added."
      redirect_to authentications_url
    else  
      user = User.new
      user.apply_omniauth(omniauth, true)
      if user.save
        flash[:notice] = "An account has been created for you and you are now logged in. Welcome."
        sign_in_and_redirect(:user, user)  
      else  
        session[:omniauth] = omniauth.except('extra')  
        session[:rebuild_user] = true
        redirect_to new_user_registration_url  
      end
    end
  end

  def destroy
    @authentication.destroy
    flash[:notice] = 'Authentication successfully removed.'
    redirect_to authentications_url
  end

end

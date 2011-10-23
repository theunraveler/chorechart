class AuthenticationsController < ApplicationController
  respond_to :html

  def index
    @authentications = user_signed_in? ? current_user.authentications : []
    @providers = @authentications.collect { |a| a.provider }
    respond_with @authentications
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'].to_s)  
    if authentication
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user  
      current_user.apply_omniauth(omniauth).save!
      flash[:notice] = "Authentication successfully added."
      redirect_to authentications_url
    else  
      user = User.new
      user.apply_omniauth(omniauth, true)
      if user.save  
        sign_in_and_redirect(:user, user)  
      else  
        session[:omniauth] = omniauth.except('extra')  
        session[:rebuild_user] = true
        redirect_to new_user_registration_url  
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = 'Successfully removed authentication.'  
    redirect_to authentications_url
  end

end

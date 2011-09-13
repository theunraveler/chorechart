class AuthenticationsController < ApplicationController
  respond_to :html

  def index
    @authentications = user_signed_in? ? current_user.authentications : []
    @providers = @authentications.collect { |a| a.provider }
    respond_with @authentications
  end

  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication  
      flash[:notice] = 'Logged in successfully.'
      sign_in_and_redirect(:user, authentication.user)
    else  
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = 'Authentication successfully added'
      redirect_to authentications_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])  
    @authentication.destroy  
    flash[:notice] = 'Successfully destroyed authentication.'  
    redirect_to authentications_url
  end
end

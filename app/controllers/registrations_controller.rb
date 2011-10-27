class RegistrationsController < Devise::RegistrationsController
  layout :choose_layout

  def choose_layout
    action_name == 'new' ? 'no_sidebar' : 'application'
  end

  def new
    @omniauth = session.has_key? :omniauth
    super
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private  

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth], session[:rebuild_user] || false)
      session[:rebuild_user] = false
      @user.valid?
    end  
  end
end

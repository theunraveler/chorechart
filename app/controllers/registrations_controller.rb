class RegistrationsController < Devise::RegistrationsController
  layout :choose_layout

  def choose_layout
    action_name != 'new' ? 'application' : 'no_sidebar'
  end

  def new
    @omniauth = session.has_key? :omniauth
    super
  end

  private  

  def build_resource(*args)
    super
    if session[:omniauth]
      resource.apply_omniauth(session[:omniauth], session[:rebuild_user] || false)
      session[:rebuild_user] = false
    end  
  end
end

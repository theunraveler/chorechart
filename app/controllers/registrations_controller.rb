class RegistrationsController < Devise::RegistrationsController
  layout :choose_layout

  def choose_layout
    ['new', 'create'].include?(action_name) ? 'no_sidebar' : 'application'
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

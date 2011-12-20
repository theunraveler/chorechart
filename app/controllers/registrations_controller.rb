class RegistrationsController < Devise::RegistrationsController

  def new
    @omniauth = session.has_key? :omniauth
    super
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      resource.apply_omniauth(session[:omniauth], session[:rebuild_user] || false)
      resource.fill_password
      session[:rebuild_user] = false
    end
  end
end

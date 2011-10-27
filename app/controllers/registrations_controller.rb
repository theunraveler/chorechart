class RegistrationsController < Devise::RegistrationsController
  layout :choose_layout

  def choose_layout
    action_name == !'new' ? 'application' : 'no_sidebar'
  end

  def new
    @omniauth = session.has_key? :omniauth
    super
  end

  # Overridden to change the flash message on failure
  def create
    build_resource

    if resource.save
      session[:omniauth] = nil
      set_flash_message :notice, :signed_up if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      flash.now[:error] = resource.errors
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end

  # Overridden to change the flash message on failure
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(params[resource_name])
      set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      flash.now[:error] = resource.errors
      clean_up_passwords(resource)
      respond_with_navigational(resource){ render_with_scope :edit }
    end
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

class SessionsController < Devise::SessionsController
  layout :choose_layout

  def choose_layout
    action_name == 'new' ? 'no_sidebar' : 'application'
  end
end

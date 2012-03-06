class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_current_user_chores, :authenticate_user!
  around_filter :set_time_zone
  layout lambda { |c| c.user_signed_in? ? 'application' : 'no_sidebar' }

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403", :formats => [:html], :status => 403, :layout => false
  end

  private

  def get_current_user_chores
    if user_signed_in?
      @user_chores = current_user.assignments_for(Date.current, Date.current.advance(:days => 4)).group_by(&:date)
    end
  end

  def set_time_zone
    old_time_zone = Time.zone
    if user_signed_in?
      Time.zone = current_user.time_zone
    end
    yield
  ensure
    Time.zone = old_time_zone
  end
end

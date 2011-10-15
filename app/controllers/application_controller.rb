class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_current_user_chores

  def get_current_user_chores
    if user_signed_in?
      @user_chores = current_user.assignments_for(Date.today, Date.today.advance(:days => 4)).group_by(&:date)
    end
  end
end

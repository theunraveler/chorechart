class UsersController < ApplicationController
  respond_to :html

  def dashboard
    @user = current_user
    respond_with @user
  end

end

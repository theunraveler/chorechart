class UsersController < ApplicationController
  respond_to :html

  def show
    @user = current_user
    respond_with @user
  end

end

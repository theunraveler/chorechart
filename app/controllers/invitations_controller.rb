class InvitationsController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :invitation, :through => :group, :shallow => true
  respond_to :html

  def new
  end

  def create
    if @invitation.save
      Notifier.invite(@invitation.email, @group, current_user).deliver
      flash[:notice] = "<em>#{@invitation}</em> has been invited to join your group <em>#{@group}</em>.".html_safe
    end
    respond_with @invitation, :location => group_memberships_path(@group.id)
  end

  def destroy
    @invitation.destroy
    flash[:notice] = "Invitation for <em>#{@invitation}</em> has been cancelled.".html_safe
    respond_with @invitation, :location => group_memberships_url(@invitation.group_id)
  end
end

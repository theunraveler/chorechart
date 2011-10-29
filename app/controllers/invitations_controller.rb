class InvitationsController < ApplicationController
  respond_to :html

  def new
    @group = Group.find(params[:group_id])
    @invitation = @group.invitations.build
    respond_with @invitation
  end

  def create
    @group = Group.find(params[:group_id])
    @invitation = Invitation.new(params[:invitation])

    respond_to do |format|
      if @invitation.save
        Notifier.invite(@invitation.email, @group, current_user).deliver
        format.html { redirect_to(group_memberships_path(@group), :notice => "<em>#{@invitation.email}</em> has been invited to join your group <em>#{@group}</em>.".html_safe) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to(group_memberships_url(@invitation.group), :notice => "Invitation for <em>#{@invitation}</em> has been cancelled.".html_safe) }
    end

  end
end

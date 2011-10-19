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
        format.html { redirect_to(group_memberships_path(@group), :notice => "<em>#{@invitation.email}</em> has been invited to the group <em>#{@group}</em>.") }
      else
        flash.now[:error] = @invitation.errors
        format.html { render :action => "new" }
      end
    end
  end

end

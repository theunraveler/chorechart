class MembershipsController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :membership, :through => :group, :shallow => true
  respond_to :html

  def index
    @group = Group.find(params[:group_id])
    @membership = Membership.new
    @user_autocomplete = User.not_in_group(@group)

    respond_with @memberships
  end

  # POST /memberships
  # POST /memberships.xml
  def create
    user = User.find_by_login(params[:membership][:user_id]).first
    if user
      params[:membership][:user_id] = user.id
      @membership = Membership.new(params[:membership])
      respond_to do |format|
        if @membership.save
          format.html { redirect_to(group_memberships_url(@group), :notice => "User #{user} has been added to the group.") }
        else
          @memberships = Membership.all
          @user_autocomplete = User.not_in_group(@group)
          format.html { render :action => "index" }
        end
      end
    else
      notice = render_to_string(:partial => "invite_user", :locals => { :user => params[:membership][:user_id], :group => @group }).html_safe
      respond_to do |format|
        format.html { redirect_to(group_memberships_url(@group), :flash => { :warning => notice }) }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.xml
  def destroy
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to(group_memberships_url(@membership.group), :notice => "User #{@membership.user} has been removed from the group") }
      format.xml  { head :ok }
    end
  end

end

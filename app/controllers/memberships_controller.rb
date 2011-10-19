class MembershipsController < ApplicationController
  respond_to :html

  def index
    @group = Group.find(params[:group_id])
    @memberships = Membership.find_all_by_group_id(@group.id)
    @membership = Membership.new
    # This doesn't scale
    @user_autocomplete = User.all.keep_if { |u| !@group.users.include?(u) }

    respond_with @memberships
  end

  # POST /memberships
  # POST /memberships.xml
  def create
    @group = Group.find(params[:group_id])
    params[:membership][:group_id] = @group.id
    user = User.find_by_login(params[:membership][:user_id]).first
    # TODO: Do something if the user doesn't exist!
    if user
      params[:membership][:user_id] = user.id
      @membership = Membership.new(params[:membership])
      respond_to do |format|
        if @membership.save
          format.html { redirect_to(group_memberships_url(@group), :notice => "User #{user.email} has been added to the group.") }
        else
          flash.now[:error] = @membership.errors
          @memberships = Membership.all
          format.html { render :action => "index" }
        end
      end
    else
      notice = render_to_string(:partial => "invite_user", :locals => { :user => params[:membership][:user_id], :group => @group })
      respond_to do |format|
        format.html { redirect_to(group_memberships_url(@group), :flash => { :warning => notice }) }
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.xml
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to(@membership, :notice => 'Membership was successfully updated.') }
        format.xml  { head :ok }
      else
        flash.now[:error] = @membership.errors        
        format.html { render :action => "edit" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.xml
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to(group_memberships_url(@membership.group)) }
      format.xml  { head :ok }
    end
  end
end

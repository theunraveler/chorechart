class MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.xml
  def index
    @group = Group.find(params[:group_id])
    @memberships = Membership.all
    @membership = Membership.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memberships }
    end
  end

  # POST /memberships
  # POST /memberships.xml
  def create
    @group = Group.find(params[:group_id])
    params[:membership][:group_id] = @group.id
    user = User.find_by_login(params[:membership][:user_id])
    params[:membership][:user_id] = user.id
    @membership = Membership.new(params[:membership])

    respond_to do |format|
      if @membership.save
        format.html { redirect_to(group_memberships_url(@group), :notice => "User #{user.email} has been added to the group.") }
        format.xml  { render :xml => @membership, :status => :created, :location => @membership }
      else
        @memberships = Membership.all
        format.html { render :action => "index" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
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
      format.html { redirect_to(memberships_url) }
      format.xml  { head :ok }
    end
  end
end

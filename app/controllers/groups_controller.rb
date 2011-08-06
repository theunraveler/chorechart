class GroupsController < ApplicationController
  respond_to :html

  # GET /groups
  def index
    @groups = current_user.groups
    respond_with @groups
  end

  # GET /groups/1
  def show
    @group = Group.find(params[:id])
    respond_with @group
  end

  # GET /groups/new
  def new
    @group = Group.new
    respond_with @group
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to(groups_url, :notice => "Group #{@group.name} created.") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group, :notice => 'Group was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
    end
  end
end

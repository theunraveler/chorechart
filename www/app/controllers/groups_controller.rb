class GroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  # GET /groups
  def index
    respond_with @groups
  end

  # GET /groups/1
  def show
    respond_with @group
  end

  # GET /groups/new
  def new
    respond_with @group
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    respond_to do |format|
      if @group.save
        @group.add_user(current_user, 'admin')
        format.html { redirect_to(groups_url, :notice => "Group #{@group.name} created.") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
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
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url, :notice => "Group #{@group.name} deleted.") }
    end
  end

end

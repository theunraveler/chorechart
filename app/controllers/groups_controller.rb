class GroupsController < ApplicationController
  load_and_authorize_resource :except => :index
  respond_to :html

  # GET /groups
  def index
    @groups = current_user.groups
    respond_with @groups
  end

  # GET /groups/1
  def show
    @week = params[:week] ? Date.parse(params[:week]).beginning_of_week : Date.today.beginning_of_week
    @chores = @group.assignments_for(@week, @week.end_of_week)
    respond_with @group
  end

  # GET /groups/new
  def new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    respond_to do |format|
      if @group.save
        @group.memberships.create(:user => current_user, :is_admin => true)
        notice = render_to_string(:partial => "success", :locals => { :group => @group }).html_safe
        format.html { redirect_to(groups_url, :notice => notice) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(groups_url, :notice => "Group <em>#{@group}</em> was successfully updated.".html_safe) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url, :notice => "Group <em>#{@group.name}</em> deleted.".html_safe) }
    end
  end
end

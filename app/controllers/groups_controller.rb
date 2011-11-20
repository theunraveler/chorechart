class GroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  # GET /groups
  def index
  end

  # GET /groups/1
  def show
    @week = params[:week] ? Date.parse(params[:week]).beginning_of_week : Date.today.beginning_of_week
    @assignments = @group.assignments_for_grouped(@week, @week.end_of_week)
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
    if @group.save
      @group.memberships.create(:user => current_user, :is_admin => true)
      flash[:notice] = render_to_string(:partial => "success", :locals => { :group => @group }).html_safe
    end
    respond_with @group, :location => groups_url
  end

  # PUT /groups/1
  def update
    if @group.update_attributes(params[:group])
      flash[:notice] = "Group <em>#{@group}</em> was successfully updated.".html_safe
    end
    respond_with @group, :location => groups_url
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    flash[:notice] = "Group <em>#{@group.name}</em> deleted.".html_safe
    respond_with @group
  end
end

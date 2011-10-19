class GroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  # GET /groups
  def index
    respond_with @groups
  end

  # GET /groups/1
  def show
    @week = params[:week] ? Date.parse(params[:week]).beginning_of_week : Date.today.beginning_of_week
    @chores = @group.assignments_for(@week, @week.end_of_week)

    respond_to do |format|
      format.html
      format.pdf { send_data @group.to_pdf(@week, @chores), :type => Mime::PDF, :filename => "#{@group}-#{@week}.pdf" }
    end
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
        format.html { redirect_to(groups_url, :notice => "Group #{@group} created.") }
      else
        flash.now[:error] = @group.errors
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(groups_url, :notice => "Group #{@group} was successfully updated.") }
      else
        flash.now[:error] = @group.errors
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

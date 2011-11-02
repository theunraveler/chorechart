class ChoresController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :chore, :through => :group, :shallow => true, :except => :index
  respond_to :html

  # GET /chores
  def index
    authorize! :admin, @group
    @chores = @group.chores
    respond_with @chores
  end

  # GET /chores/new
  def new
    @chore = Chore.new(:group_id => params[:group_id], :difficulty => 1)
    respond_with @chore
  end

  # GET /chores/1/edit
  def edit
  end

  # POST /chores
  def create
    respond_to do |format|
      if @chore.save
        format.html { redirect_to(group_chores_path(@chore.group), :notice => "Chore <em>#{@chore}</em> was successfully created.".html_safe) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /chores/1
  def update
    respond_to do |format|
      if @chore.update_attributes(params[:chore])
        format.html { redirect_to(group_chores_path(@chore.group), :notice => 'Chore was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /chores/1
  # DELETE /chores/1.xml
  def destroy
    @chore.destroy

    respond_to do |format|
      format.html { redirect_to(group_chores_url(@chore.group)) }
    end
  end
end

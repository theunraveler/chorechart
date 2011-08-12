class ChoresController < ApplicationController
  respond_to :html

  # GET /chores
  def index
    @group = Group.find(params[:group_id])
    @chores = Chore.all
    respond_with @chores
  end

  # GET /chores/1
  def show
    @chore = Chore.find(params[:id])
    respond_with @chore
  end

  # GET /chores/new
  def new
    @group = Group.find(params[:group_id])
    @chore = Chore.new
    respond_with @chore
  end

  # GET /chores/1/edit
  def edit
    @chore = Chore.find(params[:id])
  end

  # POST /chores
  def create
    @chore = Chore.new(params[:chore])

    respond_to do |format|
      if @chore.save
        format.html { redirect_to(@chore, :notice => 'Chore was successfully created.') }
        format.xml  { render :xml => @chore, :status => :created, :location => @chore }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chore.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chores/1
  def update
    @chore = Chore.find(params[:id])

    respond_to do |format|
      if @chore.update_attributes(params[:chore])
        format.html { redirect_to(@chore, :notice => 'Chore was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chore.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chores/1
  # DELETE /chores/1.xml
  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy

    respond_to do |format|
      format.html { redirect_to(chores_url) }
      format.xml  { head :ok }
    end
  end
end

class GroupMastersController < ApplicationController
  # GET /group_masters
  # GET /group_masters.json
  def index
    @group_masters = GroupMaster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_masters }
    end
  end

  # GET /group_masters/1
  # GET /group_masters/1.json
  def show
    @group_master = GroupMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_master }
    end
  end

  # GET /group_masters/new
  # GET /group_masters/new.json
  def new
    @group_master = GroupMaster.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_master }
    end
  end

  # GET /group_masters/1/edit
  def edit
    @group_master = GroupMaster.find(params[:id])
  end

  # POST /group_masters
  # POST /group_masters.json
  def create
    @group_master = GroupMaster.new(params[:group_master])

    respond_to do |format|
      if @group_master.save
        format.html { redirect_to @group_master, notice: 'Group master was successfully created.' }
        format.json { render json: @group_master, status: :created, location: @group_master }
      else
        format.html { render action: "new" }
        format.json { render json: @group_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_masters/1
  # PUT /group_masters/1.json
  def update
    @group_master = GroupMaster.find(params[:id])

    respond_to do |format|
      if @group_master.update_attributes(params[:group_master])
        format.html { redirect_to @group_master, notice: 'Group master was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_masters/1
  # DELETE /group_masters/1.json
  def destroy
    @group_master = GroupMaster.find(params[:id])
    @group_master.destroy

    respond_to do |format|
      format.html { redirect_to group_masters_url }
      format.json { head :no_content }
    end
  end
end

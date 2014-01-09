class ProcessMastersController < ApplicationController
  # GET /process_masters
  # GET /process_masters.json
  def index
    @process_masters = ProcessMaster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @process_masters }
    end
  end

  # GET /process_masters/1
  # GET /process_masters/1.json
  def show
    @process_master = ProcessMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @process_master }
    end
  end

  # GET /process_masters/new
  # GET /process_masters/new.json
  def new
    @process_master = ProcessMaster.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @process_master }
    end
  end

  # GET /process_masters/1/edit
  def edit
    @process_master = ProcessMaster.find(params[:id])
  end

  # POST /process_masters
  # POST /process_masters.json
  def create
    @process_master = ProcessMaster.new(params[:process_master])

    respond_to do |format|
      if @process_master.save
        format.html { redirect_to @process_master, notice: 'Process master was successfully created.' }
        format.json { render json: @process_master, status: :created, location: @process_master }
      else
        format.html { render action: "new" }
        format.json { render json: @process_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /process_masters/1
  # PUT /process_masters/1.json
  def update
    @process_master = ProcessMaster.find(params[:id])

    respond_to do |format|
      if @process_master.update_attributes(params[:process_master])
        format.html { redirect_to @process_master, notice: 'Process master was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @process_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /process_masters/1
  # DELETE /process_masters/1.json
  def destroy
    @process_master = ProcessMaster.find(params[:id])
    @process_master.destroy

    respond_to do |format|
      format.html { redirect_to process_masters_url }
      format.json { head :no_content }
    end
  end
end
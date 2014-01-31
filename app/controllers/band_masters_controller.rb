class BandMastersController < ApplicationController
  # GET /band_masters
  # GET /band_masters.json
  def index
    @band_masters = BandMaster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @band_masters }
    end
  end

  # GET /band_masters/1
  # GET /band_masters/1.json
  def show
    @band_master = BandMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @band_master }
    end
  end

  # GET /band_masters/new
  # GET /band_masters/new.json
  def new
    @band_master = BandMaster.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @band_master }
    end
  end

  # GET /band_masters/1/edit
  def edit
    @band_master = BandMaster.find(params[:id])
  end

  # POST /band_masters
  # POST /band_masters.json
  def create
    @band_master = BandMaster.new(params[:band_master])

    respond_to do |format|
      if @band_master.save
        format.html { redirect_to @band_master, notice: 'Band master was successfully created.' }
        format.json { render json: @band_master, status: :created, location: @band_master }
      else
        format.html { render action: "new" }
        format.json { render json: @band_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /band_masters/1
  # PUT /band_masters/1.json
  def update
    @band_master = BandMaster.find(params[:id])

    respond_to do |format|
      if @band_master.update_attributes(params[:band_master])
        format.html { redirect_to @band_master, notice: 'Band master was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @band_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /band_masters/1
  # DELETE /band_masters/1.json
  def destroy
    @band_master = BandMaster.find(params[:id])
    @band_master.destroy

    respond_to do |format|
      format.html { redirect_to band_masters_url }
      format.json { head :no_content }
    end
  end
end

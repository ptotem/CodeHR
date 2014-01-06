class CompanyMastersController < ApplicationController
  # GET /company_masters
  # GET /company_masters.json
  def index
    @company_masters = CompanyMaster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @company_masters }
    end
  end

  # GET /company_masters/1
  # GET /company_masters/1.json
  def show
    @company_master = CompanyMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company_master }
    end
  end

  # GET /company_masters/new
  # GET /company_masters/new.json
  def new
    @company_master = CompanyMaster.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company_master }
    end
  end

  # GET /company_masters/1/edit
  def edit
    @company_master = CompanyMaster.find(params[:id])
  end

  # POST /company_masters
  # POST /company_masters.json
  def create
    @company_master = CompanyMaster.new(params[:company_master])

    respond_to do |format|
      if @company_master.save
        format.html { redirect_to @company_master, notice: 'Company master was successfully created.' }
        format.json { render json: @company_master, status: :created, location: @company_master }
      else
        format.html { render action: "new" }
        format.json { render json: @company_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /company_masters/1
  # PUT /company_masters/1.json
  def update
    @company_master = CompanyMaster.find(params[:id])

    respond_to do |format|
      if @company_master.update_attributes(params[:company_master])
        format.html { redirect_to @company_master, notice: 'Company master was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_masters/1
  # DELETE /company_masters/1.json
  def destroy
    @company_master = CompanyMaster.find(params[:id])
    @company_master.destroy

    respond_to do |format|
      format.html { redirect_to company_masters_url }
      format.json { head :no_content }
    end
  end
end

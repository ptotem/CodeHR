class MasterProsController < ApplicationController
  # GET /master_pros
  # GET /master_pros.json
  def index
    @master_pros = MasterPro.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @master_pros }
    end
  end

  # GET /master_pros/1
  # GET /master_pros/1.json
  def show
    @master_pro = MasterPro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @master_pro }
    end
  end

  # GET /master_pros/new
  # GET /master_pros/new.json
  def new
    @master_pro = MasterPro.new
    @master_pro.master_steps.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @master_pro }
    end
  end

  # GET /master_pros/1/edit
  def edit
    @master_pro = MasterPro.find(params[:id])
  end

  # POST /master_pros
  # POST /master_pros.json
  def create
    @master_pro = MasterPro.new(params[:master_pro])

    respond_to do |format|
      if @master_pro.save
        format.html { redirect_to @master_pro, notice: 'Master pro was successfully created.' }
        format.json { render json: @master_pro, status: :created, location: @master_pro }
      else
        format.html { render action: "new" }
        format.json { render json: @master_pro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /master_pros/1
  # PUT /master_pros/1.json
  def update
    @master_pro = MasterPro.find(params[:id])

    respond_to do |format|
      if @master_pro.update_attributes(params[:master_pro])
        format.html { redirect_to @master_pro, notice: 'Master pro was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @master_pro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_pros/1
  # DELETE /master_pros/1.json
  def destroy
    @master_pro = MasterPro.find(params[:id])
    @master_pro.destroy

    respond_to do |format|
      format.html { redirect_to master_pros_url }
      format.json { head :no_content }
    end
  end

  def get_dropdown_data
    #render :text => params[:action_name][0]
    #return
    @models = Dir["#{Rails.root}/app/models/*.rb"].map{|i| i.sub('.rb','').sub("#{Rails.root}/app/models/","").underscore.camelize}
    render :text => @models
    return
  end

end

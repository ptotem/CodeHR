class MasterStepsController < ApplicationController
  # GET /master_steps
  # GET /master_steps.json
  def index
    @master_steps = MasterStep.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @master_steps }
    end
  end

  # GET /master_steps/1
  # GET /master_steps/1.json
  def show
    @master_step = MasterStep.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @master_step }
    end
  end

  # GET /master_steps/new
  # GET /master_steps/new.json
  def new
    @master_step = MasterStep.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @master_step }
    end
  end

  # GET /master_steps/1/edit
  def edit
    @master_step = MasterStep.find(params[:id])
  end

  # POST /master_steps
  # POST /master_steps.json
  def create
    @master_step = MasterStep.new(params[:master_step])

    respond_to do |format|
      if @master_step.save
        format.html { redirect_to @master_step, notice: 'Master step was successfully created.' }
        format.json { render json: @master_step, status: :created, location: @master_step }
      else
        format.html { render action: "new" }
        format.json { render json: @master_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /master_steps/1
  # PUT /master_steps/1.json
  def update
    @master_step = MasterStep.find(params[:id])

    respond_to do |format|
      if @master_step.update_attributes(params[:master_step])
        format.html { redirect_to @master_step, notice: 'Master step was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @master_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_steps/1
  # DELETE /master_steps/1.json
  def destroy
    @master_step = MasterStep.find(params[:id])
    @master_step.destroy

    respond_to do |format|
      format.html { redirect_to master_steps_url }
      format.json { head :no_content }
    end
  end
end

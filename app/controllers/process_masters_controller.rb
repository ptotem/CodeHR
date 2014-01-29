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
    @form_config= t('config.ProcessMaster.form.new')
    @form=@form_config[:fields]

    @process_master = ProcessMaster.new
    @process_master.step_masters.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @process_master }
    end
  end

  # GET /process_masters/1/edit
  def edit
    @form_config= t('config.ProcessMaster.form.edit')
    @form=@form_config[:fields]
    @process_master = ProcessMaster.find(params[:id])
  end

  # POST /process_masters
  # POST /process_masters.json
  def create
    #render :json=>params
    #return

    @process_master = ProcessMaster.new(params[:process_master])
    if params[:action_arr]
      @process_master.step_masters.each_with_index do |pms, index|
        if params[:action_arr][index.to_s]
          params[:action_arr][index.to_s].each do |e|
           pms.action_arr_masters.build(:a_class_name=>"EmployeeMaster", :dep_class_name=>"", :a_obj_id=>e)
          end
          pms.action_to="Array"
          pms.save!
        end
        if params[:action_app_arr][index.to_s]
          params[:action_app_arr][index.to_s].each do |e|
            pms.auto_assign_tos.build(:oclass=>"EmployeeMaster", :dep_class_name =>"",:objid=>e)
          end
          pms.action_to="Array"
          pms.save!
        end
      end
    else
      render :json => @process_master
      return
    end

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

  def get_data
    @returning_data = Array.new

    @model_name = params[:model_name][0]
    @model_name_class = @model_name.classify.constantize
    #@data = @model_name_class.all
    @data = User.all

    @data.each do |i|
      @returning_data<<"#{i.name}|#{i.email}|#{i._id}"
    end
    render :text => @returning_data
    return

  end

end

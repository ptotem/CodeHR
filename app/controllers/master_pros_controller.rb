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
    @master_steps = @master_pro.master_steps.order_by(['sequence'])
    gon.step_masters = @master_pro.master_steps
    gon.step_masters_seq = @master_pro.master_steps.asc(:sequence)
    @edit = true
  end

  # POST /master_pros
  # POST /master_pros.json
  def create
    #render :json => params
    #return
    @master_pro = MasterPro.new(params[:master_pro])
    @master_steps = @master_pro.master_steps
    index1 = 0
    index2 = 0
    @master_steps.each do |master_step|
      if master_step.action == "Approve"
        master_step.approval_obj = params[:approval][index1.to_s]
        index1 = index1+1
      elsif master_step.action == "Notify"
        master_step.notification_obj = params[:notification][index2.to_s]
        index2 = index2+1
      end
    end

    respond_to do |format|
      if @master_pro.save
        #render :json => @master_pro.master_steps[1].approval_obj
        #return
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
    #render :json => params
    #return
    respond_to do |format|
      if @master_pro.update_attributes(params[:master_pro])
        @master_steps = @master_pro.master_steps
        index1 = 0
        index2 = 0
        @master_steps.each do |master_step|
          if master_step.action == "Approve"
            master_step.approval_obj = params[:approval][index1.to_s]
            index1 = index1+1
          elsif master_step.action == "Notify"
            master_step.notification_obj = params[:notification][index2.to_s]
            index2 = index2+1
          end
        end
        #render :json => @master_pro.master_steps
        #return
        @master_pro.save
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
    #@models = Dir["#{Rails.root}/app/models/*.rb"].map{|i| i.sub('.rb','').sub("#{Rails.root}/app/models/","").underscore.camelize}

    @models = Array.new()
    @yml_models = t('forms')
    @yml_models.each do |model|
      @models << "#{model[0]}||#{model[1][:name]}"
    end

    render :text => @models
    return
  end

  def approval_pm_form
    respond_to do |format|
      format.html { render :partial => 'master_pros/approval_form', :locals => {:counter => params[:counter][0]} } # index.html.erb
      format.json { render json: @results, :callback => params[:callback] }
    end
  end

  def notification_pm_form
    respond_to do |format|
      format.html { render :partial => 'master_pros/notification_subform', :locals => {:counter => params[:counter][0]} } # index.html.erb
      format.json { render json: @results, :callback => params[:callback] }
    end
  end

  def approver_pm_form
    respond_to do |format|
      format.html { render :partial => 'master_pros/approvers', :locals => {:counter => params[:counter][0]} } # index.html.erb
      format.json { render json: @results, :callback => params[:callback] }
    end
  end

  def remove_master_step
    #render :text => params
    #return
    @master_step = MasterPro.find(params[:master_pro_id][0]).master_steps.where(:sequence => params[:master_step_id][0]).first#find(params[:master_step_id])
    @master_step.destroy
    render :text => true
    return
  end

end

class ManpowerPlanningsController < InheritedResources::Base

  def new


    @manpower_planning = ManpowerPlanning.new
    #@manpower_planning.approval_mats.build
    #@manpower_planning.vacancy_masters.build
    #@rating.write_attribute(:test1, "")
    #@fields = DynamicField.where(:oclass=>"ManpowerPlanning")
    #@fields.each do |ss|
    #  @manpower_planning.write_attribute(ss.name.to_sym,"")
    #end
  end

  def create
    @manpower_planning =ManpowerPlanning.new(params[:manpower_planning])
    @manpower_planning.period_from = Date.strptime(params[:manpower_planning][:period_from], "%m/%d/%Y")
    @manpower_planning.period_to =Date.strptime(params[:manpower_planning][:period_to], "%m/%d/%Y")
    @manpower_planning.process_id=params[:process_id]
    @manpower_planning.save
    if !params[:process_id].nil?
      @pro=ProcessTr.find(params[:process_id])
      @pro.chits.create!(name:"Manpower Planning",ocname:"ManpowerPlanning",oid:@manpower_planning._id)
      @user=current_user
      @user.current_redirect_url=''
      @user.save
      @pro.step_trs[params[:seq].to_i].end_processing_step
    end

    @user=User.find(current_user._id)
    if !@user.current_redirect_url.blank?
      redirect_to @user.current_redirect_url
      return
    end

    respond_to do |format|
      if @manpower_planning.save
        format.html { redirect_to @manpower_planning, notice: 'Manpower Planning was successfully created.' }
        format.json { render json: @manpower_planning, status: :created, location: @manpower_planning }
      else
        format.html { render action: "new" }
        format.json { render json: @manpower_planning.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @form_config= t('config.ManpowerPlanning.form.edit')
    @form=@form_config[:fields]
    @manpower_planning = ManpowerPlanning.find(params[:id])
  end

  def mp_approval
    @manpower_planning = ManpowerPlanning.find(params[:id])
    render :action => 'show'
  end

end

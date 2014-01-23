class ManpowerPlanningsController < InheritedResources::Base

  def new
    @manpower_planning = ManpowerPlanning.new
  end

  def create
    @manpower_planning =ManpowerPlanning.new(params[:manpower_planning])
    @manpower_planning.period_from = Date.strptime(params[:manpower_planning][:period_from], "%m/%d/%Y")
    @manpower_planning.period_to =Date.strptime(params[:manpower_planning][:period_to], "%m/%d/%Y")
    @manpower_planning.process_id=params[:process_id]
    @manpower_planning.status="created"
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

  def mp_release
    @manpower_planning = ManpowerPlanning.find(params[:id])
    render :action => 'show'
  end

  #Done: Building functionality for release vacancy

  def release
    @pro=ProcessTr.find(params[:process_id])
    @manpower_planning = ManpowerPlanning.find(params[:id])
    @manpower_planning.final_approved_number.to_i.times do |i|
      @vacancy = VacancyMaster.create!(:vacancy_code => "VAC#{rand(1..10000)}", :manpower_planning_id => @manpower_planning._id,:description=>"This vacancy is generated using this MP Code #{@manpower_planning._id}", :status => "")
      @pro.chits.create!(name:"Vacancy",ocname:"VacancyMaster",oid:@vacancy._id)
      @user=current_user
      @user.current_redirect_url=''
      @user.save
    end
    @pro.step_trs[params[:seq].to_i].end_processing_step
    @manpower_planning.status="released"
    @manpower_planning.save

    render :text=>"Vacancies are created for this Manpower Plan"
    return
  end

  def consolidate_manpower_plan
    @manpower_plannings = ManpowerPlanning.where(:status => "created")
    @manpower_plannings.each do |mpplan|
      @pro=ProcessTr.find(mpplan.process_id)
      mpplan.final_approved_number.to_i.times do |i|
        @vacancy = VacancyMaster.create!(:vacancy_code => "VAC#{rand(1..10000)}", :manpower_planning_id => mpplan._id,:description=>"This vacancy is generated using this MP Code #{mpplan._id}", :status => "open")
        @pro.chits.create!(name:"Vacancy",ocname:"VacancyMaster",oid:@vacancy._id)
      end
      @pro.step_trs[params[:seq].to_i].end_processing_step
      mpplan.status="released"
      mpplan.save
    end
    render :text=> "Vacancies are consolidated for all the plans"
    return
  end

  def mp_release_bulk

  end

end

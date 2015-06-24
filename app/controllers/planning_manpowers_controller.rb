class PlanningManpowersController < InheritedResources::Base

  def new
    @planning_manpower = PlanningManpower.new
    @form_config = t('config.PlanningManpower.form.new')
    @form = @form_config[:fields]
  end

  def edit
    @form_config = t('config.PlanningManpower.form.edit')
    @form = @form_config[:fields]
    @planning_manpower = PlanningManpower.find(params[:id])
  end

  def show_active_plans
    @openings = PlanningManpower.where(:status => 'Approved')
    @vacancies = []
    @openings.each do |o|
      currentVacancy =VacancyMaster.find(o['vacancy_id'])
      currentVacancy['band_master'] = BandMaster.find(o['manpower_plan_dets']['0']['band_master'])
      currentVacancy['ff_source'] = o['manpower_plan_dets']['0']['ff_source']
      currentVacancy['role'] = Role.find(o['manpower_plan_dets']['0']['role'])
      @vacancies << currentVacancy
    end


  end

  def apply_plan
    # render :json => params
    # return
    @currentVacancy =VacancyMaster.find(params[:opening_id])
    manpower = PlanningManpower.find(@currentVacancy.manpower_id)
    @currentVacancy['band_master'] = BandMaster.find(manpower['manpower_plan_dets']['0']['band_master'])
    @currentVacancy['ff_source'] = manpower['manpower_plan_dets']['0']['ff_source']
    @currentVacancy['role'] = Role.find(manpower['manpower_plan_dets']['0']['role'])
    @test = @currentVacancy
    # render :json => @currentVacancy
    # return
  end

  def successful_apply
    @file = Resume.create(:file => params[:file],:user_id => current_user._id.to_s)
    @vacancy_obj = VacancyMaster.find(params[:vacancy_id])
    temp= {}
    temp[current_user._id.to_s] = {resumeId:@file._id.to_s}
    temp['status'] = 'Applied'
    @vacancy_obj.candidates << temp
    @vacancy_obj.save!
  end

  def update_opening
    @vacancy = VacancyMaster.find(params[:opening_id])
    manpower = PlanningManpower.find(@vacancy.manpower_id)
    @vacancy['band_master'] = BandMaster.find(manpower['manpower_plan_dets']['0']['band_master'])
    @vacancy['ff_source'] = manpower['manpower_plan_dets']['0']['ff_source']
    @vacancy['role'] = Role.find(manpower['manpower_plan_dets']['0']['role'])
    @vacancy.candidates.each do |c|
      
    end
    # render :json => @vacancy_obj
    # return false
  end

  def test
    
  end

end

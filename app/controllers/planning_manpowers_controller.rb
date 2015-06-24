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
      @vacancies << VacancyMaster.find(o['vacancy_id'])
    end


  end

  def apply_plan
    @currentVacancy = VacancyMaster.find(params[:opening_id])
  end

  def successful_apply
    @file = Resume.create(:file => params[:file],:user_id => current_user._id.to_s)
    @vacancy_obj = VacancyMaster.find(params[:vacancy_id])
    @vacancy_obj.candidates[current_user._id.to_s] = {resumeId: @file._id.to_s, status: 'Applied'}
    @vacancy_obj.save!
  end

  def update_opening
    @vacancy = VacancyMaster.find(params[:opening_id])

    
  end

  def candidate_status_update
    vacancy_obj = VacancyMaster.find(params[:vacancy_id])
    vacancy_obj.candidates[params[:user_id].to_s][:status] = params[params[:user_id].to_s].to_s
    vacancy_obj.save!
  end

end

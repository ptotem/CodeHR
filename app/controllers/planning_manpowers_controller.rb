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

    # render :json => @openings
    # render :json => @vacancies
    # return
  end

end

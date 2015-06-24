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

  def show_closed_plans
    @closures = PlanningManpower.where(:status => 'Closed')
    @postings = []
    @closures.each do |o|
      @postings << VacancyMaster.find(o['vacancy_id'])
    end
  end

  def apply_plan
    @currentVacancy = VacancyMaster.find(params[:opening_id])
  end

  def close_plan
    currentVacancy = VacancyMaster.find(params[:opening_id])
    currentVacancy.status = 'Closed'
    currentVacancy.save!

    currentManpower = PlanningManpower.find(currentVacancy.manpower_id)
    currentManpower.status = 'Closed'
    currentManpower.manpower_plan_dets['0']['status'] = 'Closed'
    currentManpower.save!

    redirect_to openings_path
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
    # render :json => params
    # return
    vacancy_obj = VacancyMaster.find(params[:vacancy_id])
    if params[params[:user_id]+'_status'] == 'Accepted'
      if vacancy_obj['occupied_position'] < vacancy_obj['no_of_position']
        vacancy_obj.candidates[params[:user_id]][:status] = params[params[:user_id]+'_status']
        vacancy_obj.candidates[params[:user_id]][:proposed_ctc] = if params[params[:user_id]+'_ctc'] != "" then params[params[:user_id]+'_ctc'].to_i else 0 end
        
        title = "Offer Letter for "+vacancy_obj.role['name']
        description = "You have been selected for the post "+vacancy_obj.role['name']+". Offered CTC is Rs. "+vacancy_obj.candidates[params[:user_id]][:proposed_ctc].to_s+"/-"
        letter = Letter.create(:file => params[params[:user_id]+'_file'])
        link = letter.file.path
        vacancy_obj.candidates[params[:user_id]][:letter] = link
        notify_ctc(params[:user_id], "Offer Letter", title, description, link, "Letter")
        
      end
    else
      vacancy_obj.candidates[params[:user_id]][:status] = params[params[:user_id]+'_status']
      vacancy_obj.candidates[params[:user_id]].delete 'proposed_ctc'
      vacancy_obj.candidates[params[:user_id]].delete 'letter'

      if params[params[:user_id]+'_status'] == 'Rejected'
        title = "Rejection Letter for "+vacancy_obj.role['name']
        description = "You have been rejected for the post "+vacancy_obj.role['name']+"."
        letter = Letter.create(:file => params[params[:user_id]+'_file'])
        link = letter.file.path
        vacancy_obj.candidates[params[:user_id]][:letter] = link
        notify_ctc(params[:user_id], "Rejection Letter", title, description, link, "Letter")
        
      end
    end
    
    vacancy_obj.save!

    redirect_to :back
  end

  def notify_ctc(user_id, type, title, description, link, class_obj)
    user = User.find(user_id)
    unm=user.notification_masters.build title:title , description:description,  type:type, read: false, link: link, class_obj: class_obj, link_title: "Letter"
    unm.save
    unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
    unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
    unm.save
    user.save
  end

end

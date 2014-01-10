class CandidateMastersController < InheritedResources::Base
  def new
    @candidate_master = CandidateMaster.new
    @candidate_master.cand_educations.build
    @candidate_master.candidate_contact_numbers.build
    @candidate_master.candidate_employment_histories.build
    @candidate_master.communication_addresses.build
    @candidate_master.candidate_family_details.build
    @candidate_master.job_preferences.build
    @candidate_master.location_preferences.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"CandidateMaster")
    @fields.each do |ss|
      @candidate_master.write_attribute(ss.name.to_sym,"")
    end
  end

  #def create
  #  #render :text => params
  #  #return
  #  @candidate_master = CandidateMaster.new(params[:candidate_master])
  #
  #  @candidate_master.date_of_birth = Date.strptime(params[:candidate_master][:date_of_birth], "%m/%d/%Y")
  #  #render :json=>@candidate_master
  #  #return
  #  respond_to do |format|
  #    if @candidate_master.save
  #      format.html { redirect_to @candidate_master, notice: 'Candidate master was successfully created.' }
  #      format.json { render json: @candidate_master, status: :created, location: @candidate_master }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @candidate_master.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  def import_candidate_masters
    render :layout => false
  end

  def importing_candidate_masters
    #render :text => params[:file][:original_filename]

    if request.post? && params[:file].present?
      CandidateMaster.import(params[:file])
      #redirect_to '/employee_masters', notice: "Slides imported."
    else
      redirect_to '/import_employee_masters', notice: "Slides couldn't be imported."
    end

  end


end

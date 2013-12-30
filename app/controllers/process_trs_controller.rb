class ProcessTrsController < InheritedResources::Base
  def new
    @process_tr=ProcessTr.new
  end

  def create
    @p=ProcessMaster.find(params[:process_tr][:name])
    @process_tr=ProcessTr.create(:name=>@p.name,:user_id=>current_user._id)
    @p.step_masters.each do |sm|
      @process_tr.step_trs.build(:name=>sm.name,:oclass=>sm.oclass,:oaction=>sm.oaction,:action_to=>params[:obj_id],:content=>sm.content)
    end
    #Next line will initiate the state machine which then automatically runs all the steps include in Initiated Process/
    @process_tr.load_process
    if !current_user.current_redirect_url.blank?
      redirect_to current_user.current_redirect_url
      return
    end

    respond_to do |format|
      if @process_tr.save
        format.html { redirect_to @process_tr, notice: 'process_tr was successfully created.' }
        format.json { render json: @process_tr, status: :created, location: @process_tr }
      else
        format.html { render action: "new" }
        format.json { render json: @process_tr.errors, status: :unprocessable_entity }
      end
    end
  end

  def navigate
    render :text=>"Sunny"
    return
  end
end

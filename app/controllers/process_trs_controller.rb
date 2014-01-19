class ProcessTrsController < InheritedResources::Base
  def new
    @process_tr=ProcessTr.new
  end

  def create
    @p=ProcessMaster.find(params[:process_tr][:name])
    @process_tr=ProcessTr.create(:name=>@p.name,:user_id=>current_user._id)
    @p.step_masters.each do |sm|
      if (sm.oaction == "Notify" || sm.oaction=="Tagging")
        @step=@process_tr.step_trs.build(:name=>sm.name,:oclass=>sm.oclass,:oaction=>sm.oaction,:action_to=>sm.action_to,:content=>sm.content)
      else
        @step=@process_tr.step_trs.build(:name=>sm.name,:oclass=>sm.oclass,:oaction=>sm.oaction,:action_to=>params[:obj_id],:content=>sm.content)
      end
      sm.action_arr_masters.each do |saam|
        @step.action_arrs.build(:a_cls_name=>saam.a_class_name,:dep_clas_name=>saam.dep_class_name,:obj_id=>saam.a_obj_id)
      end
    end
    #Next line will initiate the state machine which then automatically runs all the steps include in Initiated Process/
    @process_tr.load_process
    @user  = User.find(current_user._id)
    if !@user.current_redirect_url.blank?
      redirect_to @user.current_redirect_url
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

  def edit

  end

  def navigate
    render :text=>"Sunny"
    return
  end

  def approve_process
    #This action will get called whenever any approver approves any process.
    @pro=ProcessTr.find(parmas[:process_id])
    @step_no=params[:step_no].to_i
    @app_mat=ApprovalMat.find(params[:approval_id])
    @approver=EmployeeMaster.find(params[:aapprover_id])
    #approve current process
    @approval=@app_mat.approvers.where(:active=>true,:employee_master_id=>@approver._id).first
    @approval.approved=true
    @approval.active=false
    @approval.save
    @app_mat.save
    #Checck whether all the approver finished approving.
    if @app_mat.approvers.where(:active => true).count<=0
      #Approval process finished beccause all the approvers finished approving
      @app_mat.finished=true
      @app_mat.save
      @pro.step_trs[@step_no].end_processing_step
    end
  end
end

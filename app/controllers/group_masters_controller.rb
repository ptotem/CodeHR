class GroupMastersController < ApplicationController
  # GET /group_masters
  # GET /group_masters.json
  def index
    @group_masters = GroupMaster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_masters }
    end
  end

  # GET /group_masters/1
  # GET /group_masters/1.json
  def show
    @group_master = GroupMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_master }
    end
  end

  # GET /group_masters/new
  # GET /group_masters/new.json
  def new
    @form_config= t('config.GroupMaster.form.new')
    @form=@form_config[:fields]

    @group_master = GroupMaster.new
    #@group_master.child_groups.build
    #@group_master.parent_group.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_master }
    end
  end

  # GET /group_masters/1/edit
  def edit
    @form_config= t('config.GroupMaster.form.edit')
    @form=@form_config[:fields]
    @group_master = GroupMaster.find(params[:id])
  end

  # POST /group_masters
  # POST /group_masters.json
  def create
    @group_master = GroupMaster.new(params[:group_master])
    if !params[:process_id].nil?
      @group_master.created_by_process=true
      @group_master.process_id=params[:process_id]
      @group_master.save
      @pro=ProcessTr.find(params[:process_id])
      @pro.step_trs[params[:seq].to_i].end_processing_step
      @user=current_user
      @user.current_redirect_url=''
      @user.save
    end
    respond_to do |format|
      if @group_master.save
        format.html { redirect_to @group_master, notice: 'Group master was successfully created.' }
        format.json { render json: @group_master, status: :created, location: @group_master }
      else
        format.html { render action: "new" }
        format.json { render json: @group_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_masters/1
  # PUT /group_masters/1.json
  def update
    @group_master = GroupMaster.find(params[:id])
    if !params[:process_id].nil?
      @pro=ProcessTr.find(params[:process_id])
      @pro.step_trs[params[:seq].to_i].end_processing_step
      @user=current_user
      @user.current_redirect_url=''
      @user.save
    end
    respond_to do |format|
      if @group_master.update_attributes(params[:group_master])
        format.html { redirect_to @group_master, notice: 'Group master was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_masters/1
  # DELETE /group_masters/1.json
  def destroy
    @group_master = GroupMaster.find(params[:id])
    @group_master.destroy
    if !params[:process_id].nil?
      @pro=ProcessTr.find(params[:process_id])
      @pro.step_trs[params[:seq].to_i].end_processing_step
      @user=current_user
      @user.current_redirect_url=''
      @user.save
    end
    respond_to do |format|
      format.html { redirect_to group_masters_url }
      format.json { head :no_content }
    end
  end

  def import_group_masters
    render :layout => false
  end

  def importing_group_masters
    #render :text => params[:file][:original_filename]

    if request.post? && params[:file].present?
      GroupMaster.import(params[:file])
      #redirect_to '/employee_masters', notice: "Slides imported."
    else
      redirect_to '/import_group_masters', notice: "Group Masters couldn't be imported."
    end

  end

end

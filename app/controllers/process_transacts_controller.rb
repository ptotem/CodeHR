class ProcessTransactsController < ApplicationController
  # GET /process_transacts
  # GET /process_transacts.json
  def index
    @process_transacts = ProcessTransact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @process_transacts }
    end
  end

  # GET /process_transacts/1
  # GET /process_transacts/1.json
  def show
    @process_transact = ProcessTransact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @process_transact }
    end
  end

  # GET /process_transacts/new
  # GET /process_transacts/new.json
  def new
    @process_transact = ProcessTransact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @process_transact }
    end
  end

  # GET /process_transacts/1/edit
  def edit
    @process_transact = ProcessTransact.find(params[:id])
  end

  # POST /process_transacts
  # POST /process_transacts.json
  def create
    @mp = MasterPro.find(params[:process_transact][:mp_name])
    @process_transact = ProcessTransact.create!(:name => params[:process_transact][:name], :created_by => params[:process_transact][:created_by], :facilitated_by => params[:process_transact][:faciliated_by], :user_id =>params[:process_transact][:user_id])
    @mp.master_steps.each do |sm|

      @step_transact = @process_transact.step_transacts.build(:name => sm.step_name,:action_name=> sm.action,:action_object_id=>"",:obj_name => sm.action_class)
    end

    @process_transact.load_process
    @user  = User.find(current_user._id)
    if !@user.current_redirect_url.blank?
      redirect_to @user.current_redirect_url
      return
    end

    respond_to do |format|
      if @process_tr.save
        format.html { redirect_to @process_transact, notice: 'process_tr was successfully created.' }
        format.json { render json: @process_transact, status: :created, location: @process_transact }
      else
        format.html { render action: "new" }
        format.json { render json: @process_transact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @process_transact = ProcessTransact.find(params[:id])

    respond_to do |format|
      if @process_transact.update_attributes(params[:process_transact])
        format.html { redirect_to @process_transact, notice: 'Process transact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @process_transact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /process_transacts/1
  # DELETE /process_transacts/1.json
  def destroy
    @process_transact = ProcessTransact.find(params[:id])
    @process_transact.destroy

    respond_to do |format|
      format.html { redirect_to process_transacts_url }
      format.json { head :no_content }
    end
  end
end

class ApprovalMatsController < ApplicationController
  # GET /approval_mats
  # GET /approval_mats.json
  def index
    @approval_mats = ApprovalMat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @approval_mats }
    end
  end

  # GET /approval_mats/1
  # GET /approval_mats/1.json
  def show
    @approval_mat = ApprovalMat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @approval_mat }
    end
  end

  # GET /approval_mats/new
  # GET /approval_mats/new.json
  def new
    @approval_mat = ApprovalMat.new
    @approval_mat.approvers.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @approval_mat }
    end
  end

  # GET /approval_mats/1/edit
  def edit
    @approval_mat = ApprovalMat.find(params[:id])
  end

  # POST /approval_mats
  # POST /approval_mats.json
  def create
    @approval_mat = ApprovalMat.new(params[:approval_mat])

    respond_to do |format|
      if @approval_mat.save
        format.html { redirect_to @approval_mat, notice: 'Approval mat was successfully created.' }
        format.json { render json: @approval_mat, status: :created, location: @approval_mat }
      else
        format.html { render action: "new" }
        format.json { render json: @approval_mat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /approval_mats/1
  # PUT /approval_mats/1.json
  def update
    @approval_mat = ApprovalMat.find(params[:id])

    respond_to do |format|
      if @approval_mat.update_attributes(params[:approval_mat])
        format.html { redirect_to "/approval_updation/#{@approval_mat._id}/#{params[:process_id]}/#{params[:seq]}", notice: 'Approval mat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @approval_mat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /approval_mats/1
  # DELETE /approval_mats/1.json
  def destroy
    @approval_mat = ApprovalMat.find(params[:id])
    @approval_mat.destroy

    respond_to do |format|
      format.html { redirect_to approval_mats_url }
      format.json { head :no_content }
    end
  end

  def send_approval_request
    @approval_mat = ApprovalMat.find(params[:id])
    @approval_mat.send_notification
    redirect_to "/process_trs/#{@approval_mat.process_tr_id}"
  end

  def track_approval
    @process_transact = ProcessTransact.find(params[:process_id])
    @approval = ApprovalMat.where(:process_tr_id => @process_transact.id).to_a[params[:index].to_i]
    @approvers = @approval.approvers

  end
end

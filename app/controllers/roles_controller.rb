class RolesController < InheritedResources::Base
  def new
    @role=Role.new
    @form_config= t('config.Role.form.new')
    @form=@form_config[:fields]
  end

  def create
    @role= Role.new(params[:role])
    @role.save
    if !params[:process_id].nil?
      @pro=ProcessTr.find(params[:process_id])
      @pro.step_trs[params[:seq].to_i].end_processing_step
      @user=current_user
      @user.current_redirect_url=''
      @user.save
    end
    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'role was successfully created.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render action: "new" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @form_config= t('config.Role.form.edit')
    @form=@form_config[:fields]
    @role=Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    respond_to do |format|
      if @role.update_attributes(params[:role])
        if !params[:process_id].nil?
          @pro=ProcessTr.find(params[:process_id])
          @pro.step_trs[params[:seq].to_i].end_processing_step
          @user=current_user
          @user.current_redirect_url=''
          @user.save
        end
        format.html { redirect_to @role, notice: 'Slide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @role, notice: 'Slide could not be updated.' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    if !params[:process_id].nil?
      @pro=ProcessTr.find(params[:process_id])
      @pro.step_trs[params[:seq].to_i].end_processing_step
      @user=current_user
      @user.current_redirect_url=''
      @user.save
    end
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end
end
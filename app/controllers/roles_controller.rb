class RolesController < InheritedResources::Base
  def create
    @role= Role.new(params[:role])
    @role.save
    if !params[:process_id].nil?
      @pro=ProcessTr.find(params[:process_id])
      @pro.step_trs[params[:seq].to_i].end_processing_step
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
end

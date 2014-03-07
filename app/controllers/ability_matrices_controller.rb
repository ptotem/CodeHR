class AbilityMatricesController < ApplicationController
  # GET /ability_matrices
  # GET /ability_matrices.json
  def index
    @ability_matrices = AbilityMatrix.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ability_matrices }
    end
  end

  # GET /ability_matrices/1
  # GET /ability_matrices/1.json
  def show
    @ability_matrix = AbilityMatrix.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ability_matrix }
    end
  end

  # GET /ability_matrices/new
  # GET /ability_matrices/new.json
  def new
    @ability_matrix = AbilityMatrix.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ability_matrix }
    end
  end

  # GET /ability_matrices/1/edit
  def edit
    @ability_matrix = AbilityMatrix.find(params[:id])
  end

  # POST /ability_matrices
  # POST /ability_matrices.json
  def create
    @ability_matrix = AbilityMatrix.new(params[:ability_matrix])

    respond_to do |format|
      if @ability_matrix.save
        format.html { redirect_to @ability_matrix, notice: 'Ability matrix was successfully created.' }
        format.json { render json: @ability_matrix, status: :created, location: @ability_matrix }
      else
        format.html { render action: "new" }
        format.json { render json: @ability_matrix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ability_matrices/1
  # PUT /ability_matrices/1.json
  def update
    @ability_matrix = AbilityMatrix.find(params[:id])

    respond_to do |format|
      if @ability_matrix.update_attributes(params[:ability_matrix])
        format.html { redirect_to @ability_matrix, notice: 'Ability matrix was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ability_matrix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ability_matrices/1
  # DELETE /ability_matrices/1.json
  def destroy
    @ability_matrix = AbilityMatrix.find(params[:id])
    @ability_matrix.destroy

    respond_to do |format|
      format.html { redirect_to ability_matrices_url }
      format.json { head :no_content }
    end
  end
end

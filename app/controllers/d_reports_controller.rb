class DReportsController < ApplicationController
  # GET /d_reports
  # GET /d_reports.json
  def index
    @d_reports = DReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_reports }
    end
  end

  # GET /d_reports/1
  # GET /d_reports/1.json
  def show
    @d_report = DReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_report }
    end
  end

  # GET /d_reports/new
  # GET /d_reports/new.json
  def new
    @d_report = DReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_report }
    end
  end

  # GET /d_reports/1/edit
  def edit
    @d_report = DReport.find(params[:id])
  end

  # POST /d_reports
  # POST /d_reports.json
  def create
    @d_report = DReport.new(params[:d_report])

    respond_to do |format|
      if @d_report.save
        format.html { redirect_to @d_report, notice: 'D report was successfully created.' }
        format.json { render json: @d_report, status: :created, location: @d_report }
      else
        format.html { render action: "new" }
        format.json { render json: @d_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_reports/1
  # PUT /d_reports/1.json
  def update
    @d_report = DReport.find(params[:id])

    respond_to do |format|
      if @d_report.update_attributes(params[:d_report])
        format.html { redirect_to @d_report, notice: 'D report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_reports/1
  # DELETE /d_reports/1.json
  def destroy
    @d_report = DReport.find(params[:id])
    @d_report.destroy

    respond_to do |format|
      format.html { redirect_to d_reports_url }
      format.json { head :no_content }
    end
  end

  def show_report
    @first_dreport = DReport.first
    @d_reports = DReport.all
  end

end

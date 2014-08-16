class DReportsController < ApplicationController
  # GET /d_reports
  # GET /d_reports.json
  def index
    @d_reports = DReport.all
    # render :json => @d_reports
    # return

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_reports }
    end
  end

  # GET /d_reports/1
  # GET /d_reports/1.json
  def show
    @d_report = DReport.find(params[:id])
    @query_statements = @d_report.report_query_statements
    @main_array = []
    @query_statements.each do |e|
      @a={}
      @rqs = e
      @final_array = Array.new
      @class=eval(@rqs.classname)
      grp_by=@rqs.grp_by
      @fields=@rqs.field
      @association=@rqs.association
      @arr=@class.group_by(grp_by)
      @arr.each do |arr|
        @fields.each do |i|
          @temp=Hash.new
          @temp[:cname] = i
          @temp[:cvalue] = arr.instance_eval(i)
          @a = @a.merge({@temp[:cname]=>@temp[:cvalue]})
        end
        @association = @rqs.association.group_by { |d| d["classname"] }
        @assarr = []
        @association.keys.map do |i|
          key = @class.reflections.select{|j,v| v.class_name ==i}.keys.first
          @assarr << key
          c= Hash.new {|h,k| h[k]=[]}
          if(@class.reflections.select{|v,i| i.relation.to_s.include?('Many')}.map{|i| i[0]}.include?(key))
            c1 = Hash.new
            if !arr.instance_eval(key).nil?
              arr.instance_eval(key).each do |rec|
                @association[i].each do |d|
                  @temp=Hash.new
                  @str=d["myfield"]
                  @temp[@str] = rec.instance_eval(@str)
                  c1 = c1.merge(@temp)
                end
                c[key.to_sym] << c1
                @a = @a.merge(c)
              end
            end

            # c= Hash.new {|h,k| h[k]=[]}
            # @temp=Hash.new
            # @str=i["myfield"]
            # if !arr.instance_eval(key).nil?
            #   arr.instance_eval(key).each do |rec|
            #     @temp[:cname] = @str
            #     @temp[:cvalue]=rec.instance_eval(@str)
            #     c[key.to_sym] << {@temp[:cname]=>@temp[:cvalue]}
            #     @a = @a.merge(c)
            #   end
            # end
          else
            @temp=Hash.new
            @str=i["myfield"]
            @temp[:cname] = @str
            @temp[:cvalue] = arr.instance_eval(key).instance_eval(@str) rescue nil
            @a = @a.merge({@temp[:cname]=>@temp[:cvalue]})
          end
        end
        @final_array << @a
        @main_array << @final_array
        @a = {}
      end
    end

    # render :json => @d_report.report_query_statements
    # return
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
    # render :text => params[:query_statement_id]
    #render :text => params[:d_report]
    #return
    @rqs = ReportQueryStatement.find(params[:query_statement_id])
    @d_report = DReport.new(params[:d_report])
    @d_report.save!
    @rqs.d_report = @d_report
    @rqs.save!


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

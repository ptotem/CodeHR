class WelcomesController < InheritedResources::Base

  #layout "reporting_layout", only: [:show_my_report]

  def report
    @models = Dir["#{Rails.root}/app/models/*.rb"].map{|i| i.sub('.rb','').sub("#{Rails.root}/app/models/","").underscore.camelize}
  end

  def get_fields
    @class_name=params[:class_name]
    @fields= Hash.new
    @association_arr = Array.new
    @fields[:col_name]=eval(@class_name).fields.keys
    @fields[:associations]#[:cname]=
    eval(@class_name).reflections.values.map{|i| i.class_name}.each do |i|
      @association=Hash.new
      @association[:class_name]=i
      @association[:fields] = eval(i).fields.keys
      @association_arr << @association
    end
    @fields[:association]=@association_arr
    render :json => @fields
  end

  def get_data
    # render :json => params[:classname][0]
    # return
    @rqs = ReportQueryStatement.create!(:association => params[:association][0],:classname => params[:classname][0], :field => params[:field][0], :grp_by =>params[:group_by])
    render :text => @rqs.id
  end

  def get_data1
    # render :json => params
    # return
    @d_report = DReport.new
    @d_reports = DReport.all
    # render :json => @d_reports
    # return

    @a={}
    @rqs = ReportQueryStatement.find(params[:stmt_id])
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
      @a = {}
    end




    # render :json => @final_array
    # return
  end

  def my_report


    @cl_name = params[:cl_name][0]
    @cl_fields = params[:cl_fields][0].to_a
    @report_date = params[:report_date][0]
    @reviewed_by = params[:reviewed_by][0]
    @report_name = params[:report_name][0]
    @obj_hash = params[:newArray][0].to_a
    @d_report = DReport.create(report_name:@report_name,report_date: @report_date, reviewed_by: @reviewed_by, cl_name: @cl_name, cl_fields: @cl_fields, object_hash: @obj_hash)
    @d_report.save!


    #render :json => @obj_hash
  #  #return
  #  @d_report_count = DReport.count
  #
  #  if @d_report_count == 0
  #    @d_report = DReport.create(report_date: @report_date, reviewed_by: @reviewed_by, cl_name: @cl_name, cl_fields: @cl_fields, object_hash: @obj_hash)
  #    @d_report.save!
  #    render :json => "if _ #{@d_report.cl_name} _ #{@d_report.cl_fields} _ #{@d_report.report_date} _ #{@d_report.reviewed_by} _ #{@d_report.object_hash}"
  #    return
  #  else
  #    @first_dreport = DReport.first
  #    @first_dreport_date = @first_dreport.report_date
  #    @first_dreport_reviewed_by = @first_dreport.reviewed_by
  #    @d_report = DReport.create(report_date: @first_dreport_date, reviewed_by: @first_dreport_reviewed_by, cl_name: @cl_name, cl_fields: @cl_fields, object_hash: @obj_hash)
  #    @d_report.save!
  #    render :json => "else _ #{@d_report.cl_name} _ #{@d_report.cl_fields} _ #{@d_report.report_date} _ #{@d_report.reviewed_by} _ #{@d_report.object_hash}"
  #    return
  #  end
  #
  end

  def assessment_tracker
    # render :text => "Sunny"
    # return
  end

  def employee_assessment
    @p = PmsAssessment.where(:employee_id => current_user.employee_master.id).first

    if @p.nil?
      Goal.last.kras.each do |g|
        g.subkras.each do |gs|
          PmsAssessment.create!(:goal_id => Goal.last.id, :kra_id => gs.id, :employee_id => current_user.employee_master.id,:kra_name =>gs.kra_name,:moae =>gs.kpi_value,:moaa =>0,:weightage =>gs.weightage,:feedback=>'',:cr=>0,:sr =>0,:mr=>0,:fr=>0)
        end
      end
    end
  end

  def manager_assessment
    @p = PmsAssessment.where(:employee_id => params[:employee_id],:goal_id => params[:goal_id])
  end

  def goal_index
    @columns = ['id','kra_name']
    # @goals = Goal.first.kras.order_by([params['sidx'], :asc]).paginate(
    #     :page => params[:page],
    #     :per_page => params[:per_page]
    # )
    row =[]
    if Goal.where(:obj_class => "EmployeeMaster", :obj_id => current_user.employee_master.id).length <=0
      @goal = Goal.where(:obj_class => "GroupMaster", :obj_id => current_user.employee_master.id).length <=0
    end
    Goal.last.kras.order_by([params['sidx'], :asc]).each do |t|
      cell =[]
      @columns.each do |c|
        cell << t.instance_eval(c)
      end
      row << {:id => t.id, :cell =>cell}
    end
    a={:page => 1,:total => 1,:records => 1, :rows => row}
    if request.xhr?
      render :json => a
    end
  end

  def subgoal_index
    if !params[:manager]
      u = current_user.employee_master.id
    else
      u = params[:employee_id]
    end
    @columns = ['id','kra_name','moae','moaa','weightage','feedback','cr','sr','mr','fr']
    # @goals = Kra.find(params[:kra_id]).subkras.order_by([params['sidx'], :asc]).paginate(
    #     :page => params[:page],
    #     :per_page => params[:per_page]
    # )
    row =[]
    Kra.find(params[:kra_id]).subkras.order_by([params['sidx'], :asc]).each do |t|
      cell =[]
      @ea = PmsAssessment.where(:employee_id => u,:kra_id => t.id).first
      @columns.each do |c|
        cell << @ea.instance_eval(c) rescue ""
      end
      row << {:id => t.id, :cell =>cell}
    end
    a={:page => 1,:total => 1,:records => 1, :rows => row}
    if request.xhr?
      render :json => a
    end
    # if request.xhr?
    #   a={:page => 1,:total => 1,:records => 1,:rows => [{:id =>"5385d6d2d6ca3f1093000001",:cell => ["5385d6d2d6ca3f1093000001","K1"]}]}
    #   render :json => a
    # end
  end

  def subgoals
    @p = PmsAssessment.find(params["ID"].to_s)
    cr = (((params[:Achieved].to_f/@p.moae.to_f)*@p.weightage)/100).round(2)
    if !params[:manager]
      @p.update_attributes(:feedback => params["FEEDBACK"],:moaa => params[:Achieved],:cr=>cr,:sr => params["Self"].to_f)
    else
      @p.update_attributes(:feedback => params["FEEDBACK"],:moaa => params[:Achieved],:mr => params["Manager"].to_f,:fr =>params["Manager"].to_f)
    end
    render :json => @p
    return
  end

  def pms_normalization
    a = EmployeeMaster.all.map{|i| i.final_rating(Goal.last.id).round}

    b = (1..5).map{|i| a.count(i)}
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Performance Management - Bell Curve"})
      f.options[:xAxis][:categories] = ['1', '2', '3', '4', '5']
      f.labels(:items=>[:html=>"Company Overall Rating", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
      # f.series(:type=> 'column',:name=> 'Jane',:data=> [3, 2, 1, 3, 4])
      # f.series(:type=> 'column',:name=> 'John',:data=> [2, 3, 5, 7, 6])
      # f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
      # f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
      # GroupMaster.all.each do |e|
      #   a1 = e.employee_masters.map{|i| i.final_rating(Goal.last.id).floor}
      #   b1 = (1..5).map{|i| a1.count(i)}
      #   f.series(:type=> 'spline',:name=> e.group_name, :data=> b1)
      # end
      f.series(:type=> 'spline',:name=> 'Average', :data=> b)
      # f.series(:type=> 'pie',:name=> 'Total consumption',
      #          :data=> [
      #              {:name=> 'Jane', :y=> 13, :color=> 'red'},
      #              {:name=> 'John', :y=> 23,:color=> 'green'},
      #              {:name=> 'Joe', :y=> 19,:color=> 'blue'}
      #          ],
      #          :center=> [100, 80], :size=> 100, :showInLegend=> false)
    end
  end


  def get_report_of
    #@users = User.all
    #@employee_masters = EmployeeMaster.all
    #
    #render :pdf => 'show_my_report',
    #       :user_style_sheet               => "#{Rails.root}/app/assets/stylesheets/pdf.css",
    #       :header => { :right => '[0] of [1]' }

  end

  def display_report_of

  end

  def generate_pdf_report
    @emp_master_name = EmployeeMaster.find("#{params[:employee_master]}").employee_name
    @emp_mgr_name =EmployeeMaster.find("#{params[:employee_master]}").parents.first.employee_name
    @message = params[:message]

    #render :text => "#{@emp_master_name}, #{@message}"
    #return


    render :pdf => 'show_report', :user_style_sheet => "#{Rails.root}/app/assets/stylesheets/pdf.css"
  end


  def pms_normalization_grp_wise
    @group_master = GroupMaster.find(params[:group_master_id])
    a = @group_master.employee_masters.all.map{|i| i.final_rating(Goal.last.id).floor}
    b = (1..5).map{|i| a.count(i)}
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.plotOptions({ series: { enableMouseTracking: false, shadow: false, animation: false }})
      f.title({ :text=>"Performance Management - Bell Curve"})
      f.options[:xAxis][:categories] = ['1', '2', '3', '4', '5']
      f.labels(:items=>[:html=> @group_master.group_name+"- Rating", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
      f.series(:type=> 'spline',:name=> 'Average', :data=> b)
    end
    # render :pdf => 'show_my_report',
    #        :user_style_sheet               => "#{Rails.root}/app/assets/stylesheets/pdf.css",
    #        :header => { :right => '[0] of [1]' }

  end

  def send_employee_data
    @group_master = GroupMaster.find(params[:group_master_id][0])
    @a = []
    @group_master.employee_masters.each do |e|
      @a << { id:e.id,name:e.employee_name }
    end
    render :json =>@a
    return
  end

  def self_assessment
    # render :text => "8989"
    # return
    goal_id = Goal.last.id
    @columns = ["id", "employee_name", 'final_rating("'+goal_id+'")']

    row =[]
    # Kra.find(params[:kra_id]).subkras.order_by([params['sidx'], :asc]).each do |t|
      cell =[]
      @ea = current_user.employee_master
      @columns.each do |c|
        cell << @ea.instance_eval(c) rescue ""
      end
      row << {:id => @ea.id, :cell =>cell}
    # end
    a={:page => 1,:total => 1,:records => 1, :rows => row}
    if request.xhr?
      render :json => a
    end

  end

  def reportee_assessment
    # render :text => "params"
    # return
    goal_id = Goal.last.id
    @columns = ["id", "employee_name", 'final_rating("'+goal_id+'")']

    row =[]
    current_user.employee_master.reps.order_by([params['sidx'], :asc]).each do |t|
      cell =[]
      @ea = t
      @columns.each do |c|
        cell << @ea.instance_eval(c) rescue ""
      end
      row << {:id => t.id, :cell =>cell}
    end
    a={:page => 1,:total => 1,:records => 1, :rows => row}
    if request.xhr?
      render :json => a
    end
  end

end

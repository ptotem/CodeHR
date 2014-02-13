class WelcomesController < InheritedResources::Base
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
    @a={}
    @final_array = Array.new
    @class=eval(params[:classname][0])
    grp_by=params[:group_by][0]
    @fields=params[:field][0]
    @association=params[:association][0]
    @arr=@class.group_by(grp_by)
    @arr.each do |arr|
      @fields.each do |i|
        @temp=Hash.new
        @temp[:cname] = i
        @temp[:cvalue] = arr.instance_eval(i)
        @a = @a.merge({@temp[:cname]=>@temp[:cvalue]})
      end
      @association.map do |i|
        key = @class.reflections.select{|j,v| v.class_name ==i[:classname]}.keys.first
        @temp=Hash.new
        @str=i[:myfield]
        @temp[:cname] = @str
        @temp[:cvalue] = arr.instance_eval(key).instance_eval(@str) rescue nil
        @a = @a.merge({@temp[:cname]=>@temp[:cvalue]})
      end
      @final_array << @a
      @a = {}
    end




    render :json => @final_array
    return
  end

  def my_report

    #render :json => params
    #return

    @cl_name = params[:cl_name][0]
    @report_date = params[:report_date][0]
    @reviewed_by = params[:reviewed_by][0]

    @obj_hash = params[:newArray][0].to_a

    #render :json => @obj_hash
    #return

    #gon.json={
    #    :object_hash =>
    #        {
    #            :classname => @cl_name,
    #            :rows =>
    #                @obj_hash.each_with_index do |obj_hash, index|
    #                  {
    #                      :"row" => obj_hash
    #                  }
    #                end
    #        }
    #
    #}.to_json

    #render :json => gon.json
    #return


    @newa = Array.new
    @d_report_count = DReport.count

    if @d_report_count == 0
      @d_report = DReport.create(report_date: @report_date, reviewed_by: @reviewed_by)
      #@d_report.save!
      @obj_hash.each_with_index do |obj_hash, index|
        @d_report.object_hash << obj_hash
        @d_report.save!
      end
      render :json => "if _ #{gon.json}"
      return
    else
      @d_report = DReport.last
      #@d_report.object_hash << @obj_hash
      @d_report.object_hash << gon.json
      @d_report.save!
      render :json => "else _ #{@d_report.object_hash} _ #{gon.json}"
      return
    end

  end


end

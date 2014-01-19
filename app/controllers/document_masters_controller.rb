class DocumentMastersController < InheritedResources::Base

  def new
    @form_config= t('config.DocumentMaster.form.new')
    @form=@form_config[:fields]
    @document_master = DocumentMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"DocumentMaster")
    @fields.each do |ss|
      @document_master.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.DocumentMaster.form.edit')
    @form=@form_config[:fields]
    @document_master = DocumentMaster.find(params[:id])
  end

  def show
    @document_master = DocumentMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document_master }
    end
  end

  def doc_master_approval
    @document_master = DocumentMaster.find(params[:id])
    render :action => :show
  end

  def approve_doc_master
    render :text => "hello"
    return
  end

end

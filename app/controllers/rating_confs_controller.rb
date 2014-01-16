class RatingConfsController < InheritedResources::Base

  def index
    @rating_confs = RatingConf.all

    #render :json => @rating_confs
    #return

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rating_confs }
    end

  end

  #def new
  #  @rating_conf = RatingConf.new
  #end

  def new
    @form_config= t('config.RatingConf.form.new')
    @form=@form_config[:fields]

    @rating_conf = RatingConf.new

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @rating_conf }
    #end

  end

  def edit
    @form_config= t('config.RatingConf.form.edit')
    @form=@form_config[:fields]
    @rating_conf = RatingConf.find(params[:id])
  end

  def update
    @rating_conf = RatingConf.where(params[:id])

    respond_to do |format|
      if @rating_conf.update_attributes(params[:rating_conf])
        format.html { redirect_to(@rating_conf, :notice => 'User was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @rating_conf.errors.full_messages, :status => :unprocessable_entity }
      end
    end
  end


end

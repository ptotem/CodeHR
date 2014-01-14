class ClientsController < InheritedResources::Base
  #def new
  #  @clie=Client.new
  #  @clie.admin_users.build
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @clie }
  #  end
  #end

  def new
    @form_config= t('config.Client.form.new')
    @form=@form_config[:fields]
    @client=Client.new
    @client.admin_users.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  def edit
    @form_config= t('config.Client.form.edit')
    @form=@form_config[:fields]
    @client = Client.find(params[:id])
  end

end

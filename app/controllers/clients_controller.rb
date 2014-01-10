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
    @client=Client.new
    @client.admin_users.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end
end

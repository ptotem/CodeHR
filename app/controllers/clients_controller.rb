class ClientsController < InheritedResources::Base
  def new
    @client1=Client.new
    @client1.admin_users.build
  end
end

module ApplicationHelper
  def step_processing(oclass,oaction,action_to,content,pid,stepno,user_id)
    #redirect_to "/roles/new"
    #Todo create a switch case based on different type of action
    case oaction
      when "Creation"
        @user=User.find(user_id)
        puts @user
        @user.current_redirect_url="/role_creation/#{pid}/#{stepno}"
        @user.save
      when "Notify"
        #call Notify action
    end

  end


end

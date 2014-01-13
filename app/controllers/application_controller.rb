class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  def self.process_redirection(user_id)
    @user = User.find(user_id)
    if !@user.current_redirect_url.blank?
      ActionController::Base.redirect_to @user.current_redirect_url
      return
    end
  end

end

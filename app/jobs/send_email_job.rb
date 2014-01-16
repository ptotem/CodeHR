module SendEmailJob
  @queue = :send_emails
  def self.perform(user_id)
    User.create!(:email=>"quesrt@12345.com", :password=>"password", :password_confirmation=>"password")
    puts "Inside Send email Job.....#{user_id}"
    Resque.remove_schedule("send_email_#{user_id}")
  end
end

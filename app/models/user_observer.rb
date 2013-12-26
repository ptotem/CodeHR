class UserObserver < Mongoid::Observer
  def after_save(user)
    #Notifications.article("admin@do.com", "New article", article).deliver
    puts "Testing whether observer is working in rails 3...."
    #Notifications.user("admin@example.com", "New User", user).deliver
    puts "Checking"
  end
end
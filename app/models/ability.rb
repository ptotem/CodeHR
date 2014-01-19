#require 'cancan/model_adapters/mongoid_adapter' if defined? Mongoid

class Ability
  include CanCan::Ability

  def initialize(user)
    #cannot :manage, :all
    #cannot :read, :all # allow everyone to read everything

    #user ||= User.new
    #if user.email=='example@ptotem.com'
    #  can :access, :rails_admin # only allow admin users to access Rails Admin
    #  can :dashboard # allow access to dashboard
    #  #can :manage, User # allow authors to do anything to Slides
    #  #can :manage, EmployeeMaster
    #  can :manage, CompanyMaster, :priority.lt => 1
    #  #can :manage, :all
    #else
    #  #cannot :access, :rails_admin
    #  cannot :manage, :all
    #  can :access, :rails_admin # grant access to rails_admin
    #  can :dashboard
    #end

  end

end

class GoalsController < InheritedResources::Base
  def new
    @goal = Goal.new
    @level = "CompanyMaster"
    @sf = "company_name"
  end
end

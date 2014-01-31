class SalaryStrucuturesController < InheritedResources::Base
  def new
    @salary_structure =SalaryStrucuture.new

  end
end

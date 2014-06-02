# require 'ffaker'
namespace :db do
  task :populate => :environment do

    EmployeeMaster.all.each do |e|
      Goal.last.kras.each do |g|
        g.subkras.each do |gs|
          PmsAssessment.create!(:goal_id => Goal.last.id, :kra_id => gs.id, :employee_id => e.id,:kra_name =>gs.kra_name,:moae =>gs.kpi_value,:moaa =>gs.kpi_value,:weightage =>gs.weightage,:feedback=>'',:cr=>rand(0.01..0.32).round(2),:sr =>0,:mr=>0,:fr=>0)
        end
      end
    end
  end

end
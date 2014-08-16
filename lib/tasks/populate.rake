# require 'ffaker'
namespace :db do
  task :populate => :environment do

    (EmployeeMaster.all - EmployeeMaster.where(:official_email => "sunny@ptotem.com")).each do |e|
      Goal.last.kras.each do |g|
        g.subkras.each do |gs|
          PmsAssessment.create!(:goal_id => Goal.last.id, :kra_id => gs.id, :employee_id => e.id,:kra_name =>gs.kra_name,:moae =>gs.kpi_value,:moaa =>gs.kpi_value,:weightage =>gs.weightage,:feedback=>'Some Feedback and description..',:cr=>rand(0.01..0.9).round(2),:sr =>rand(1..5),:mr=> rand(1..5),:fr=>rand(1..5))
        end
      end
    end
  end

end
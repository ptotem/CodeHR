class AssessmentSchedule
  include Mongoid::Document
  field :employee_master_id, type: String
  field :from_date, type: Date
  field :from_time, type: Time
end

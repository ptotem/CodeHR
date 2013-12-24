class InterviewerList
  include Mongoid::Document
  field :interview_type_id, type: String
  field :interviewer, type: String
  field :fromdate, type: Date
  field :fromtime, type: Time
  field :to_date, type: Date
  field :to_time, type: Time
  embedded_in :vacancy_scheduling
end

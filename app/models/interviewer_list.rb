class InterviewerList
  include Mongoid::Document
  include Mongoid::Timestamps
  field :interview_type_id, type: String
  field :interviewer, type: String
  field :fromdate, type: Date
  field :fromtime, type: Time
  field :to_date, type: Date
  field :to_time, type: Time
  field :deleted, type: Boolean
  embedded_in :vacancy_scheduling


end

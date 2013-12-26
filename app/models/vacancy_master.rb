class VacancyMaster
  include Mongoid::Document
  field :vacancy_code, type: String
  field :manpower_planning_id, type: Integer
  field :description, type: String
  field :status, type: String
  field :sourcing_strategy, type: String
  field :hr_rep, type: String
  field :hiring_manager, type: String
  field :ctc_range_from, type: Integer
  field :ctc_range_to, type: Integer

  belongs_to :group_master
  belongs_to :job_description_master
  belongs_to :manpower_planning
  has_many :vacancy_schedulings
  accepts_nested_attributes_for :vacancy_schedulings
end

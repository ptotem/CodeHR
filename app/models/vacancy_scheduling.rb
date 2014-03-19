class VacancyScheduling
  include Mongoid::Document
  include Mongoid::Timestamps
  field :deleted, type: Boolean

  belongs_to :candidate_master
  belongs_to :vacancy_master
  embeds_many :interviewer_lists
  has_many :ratings
  accepts_nested_attributes_for :interviewer_lists
  accepts_nested_attributes_for :ratings

  validates :interview_type_id, :presence => true

  #validates :candidate_master_id, :presence => true
  #validates :vacancy_master_id, :presence => true

  #validates :interviewer_lists, :presence => true

end

class VacancyScheduling
  include Mongoid::Document
  belongs_to :candidate_master
  belongs_to :vacancy_master
  embeds_many :interviewer_lists
  has_many :ratings
  accepts_nested_attributes_for :interviewer_lists
  accepts_nested_attributes_for :ratings
end

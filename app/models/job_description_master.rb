class JobDescriptionMaster
  include Mongoid::Document
  field :job_code, type: String
  field :job_title, type: String
  field :description, type: String
  field :min_year_of_experience, type: Integer
  field :deleted, type: Boolean

  embeds_many :qualifications
  has_many :manpower_plannings
  has_many :vacancy_masters

  accepts_nested_attributes_for :qualifications
  accepts_nested_attributes_for :manpower_plannings
  accepts_nested_attributes_for :vacancy_masters


end

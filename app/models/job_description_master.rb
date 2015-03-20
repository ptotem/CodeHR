class JobDescriptionMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :job_code, type: String
  field :job_title, type: String
  field :description, type: String
  field :min_year_of_experience, type: Integer
  field :erased, type: Boolean
  has_mongoid_attached_file :jdfile

  embeds_many :qualifications
  has_many :planning_manpowers
  has_many :vacancy_masters
  has_many :roles

  accepts_nested_attributes_for :qualifications
  accepts_nested_attributes_for :planning_manpowers
  accepts_nested_attributes_for :vacancy_masters


end

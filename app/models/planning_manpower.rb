class PlanningManpower
  include Mongoid::Document
  include Mongoid::Timestamps
  field :mp_code, type: String
  field :group, type: String
  field :band, type: String
  field :position, type: String
  field :position_nature, type: String
  field :ff_source, type: String
  field :location, type: String
  field :supervisor, type: String
  field :comments, type: String
  field :erased, type: Boolean
  belongs_to :group_master
  belongs_to :job_description_master

  has_many :vacancy_masters
  has_many :job_description_masters

  accepts_nested_attributes_for :vacancy_masters

  validates :mp_code, :presence => true

end

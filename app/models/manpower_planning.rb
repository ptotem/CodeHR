class ManpowerPlanning
  include Mongoid::Document
  field :mp_code, type: String
  field :period_from, type: Date
  field :period_to, type: Date
  field :requested_by, type: String
  field :final_approved_number, type: String

  belongs_to :group_master
  belongs_to :job_description_master

  embeds_many :approval_mats
  has_many :vacancy_masters

  accepts_nested_attributes_for :approval_mats
  accepts_nested_attributes_for :vacancy_masters

  validates :mp_code, :presence => true

  validates :period_from, :presence => true
  validates_date :period_from, :before => lambda { :period_to }

  validates :period_to, :presence => true
  validates_date :period_to, :after => lambda { :period_from }

  validates :requested_by, :presence => true
  validates :final_approved_number, :presence => true

end

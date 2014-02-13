class MasterPro
  include Mongoid::Document
  field :name, type: String
  has_many :master_steps
  accepts_nested_attributes_for :master_steps
  attr_accessible :master_steps_attributes
end
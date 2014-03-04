class MasterPro
  include Mongoid::Document
  field :name, type: String
  field :deleted, type: Boolean
  has_many :master_steps
  accepts_nested_attributes_for :master_steps
end
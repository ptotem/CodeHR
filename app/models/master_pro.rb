class MasterPro
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :erased, type: Boolean
  has_many :master_steps
  accepts_nested_attributes_for :master_steps
end

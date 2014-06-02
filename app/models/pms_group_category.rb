class PmsGroupCategory
  include Mongoid::Document
  field :name, type: String
  field :percentage, type: Integer
  field :linked_to, type: Integer
  field :goal_id

  belongs_to :goal
  has_many :pms_subgroups
  accepts_nested_attributes_for :pms_subgroups
end

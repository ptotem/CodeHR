class CustomCondition
  include Mongoid::Document
  field :name, type: String
  field :is_all, type: Boolean
  field :istrue, type: Boolean
  embedded_in :custom_rule

  embeds_many :condition_stmts
  accepts_nested_attributes_for :condition_stmts

end

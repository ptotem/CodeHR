class RuleAction
  include Mongoid::Document
  field :obje
  field :funct
  field :deleted, type: Boolean
  embedded_in :custom_rule


end

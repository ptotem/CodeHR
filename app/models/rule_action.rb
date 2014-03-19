class RuleAction
  include Mongoid::Document
  include Mongoid::Timestamps
  field :obje
  field :funct
  field :deleted, type: Boolean
  embedded_in :custom_rule


end

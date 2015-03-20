class RuleAction
  include Mongoid::Document
  include Mongoid::Timestamps
  field :obje
  field :funct
  field :erased, type: Boolean
  embedded_in :custom_rule


end

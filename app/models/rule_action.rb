class RuleAction
  include Mongoid::Document
  field :obje
  field :funct

  embedded_in :custom_rule


end

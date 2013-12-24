class ConditionStmt
  include Mongoid::Document
  field :varr, type: String
  field :expression, type: String
  field :val, type: String
  embedded_in :custom_condition
end

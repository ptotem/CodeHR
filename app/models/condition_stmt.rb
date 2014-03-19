class ConditionStmt
  include Mongoid::Document
  include Mongoid::Timestamps
  field :varr, type: String
  field :expression, type: String
  field :val, type: String
  field :deleted, type: Boolean
  embedded_in :custom_condition
end

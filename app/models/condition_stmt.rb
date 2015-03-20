class ConditionStmt
  include Mongoid::Document
  include Mongoid::Timestamps
  field :varr, type: String
  field :expression, type: String
  field :val, type: String
  field :erased, type: Boolean
  embedded_in :custom_condition
end

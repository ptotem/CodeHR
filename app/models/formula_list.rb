class FormulaList
  include Mongoid::Document
  include Mongoid::Timestamps
  field :salary_component_id, type: String
  field :fixed_value, type: Float
  field :internal_formula, type: String
  field :related_to, type: String
  field :associated_to, type: String
  field :deleted, type: Boolean
  embedded_in :compensation_component
end

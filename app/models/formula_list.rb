class FormulaList
  include Mongoid::Document
  field :salary_component_id, type: String
  field :fixed_value, type: Float
  field :internal_formula, type: String
  field :fixed, type: Boolean
  embedded_in :compensation_component
end

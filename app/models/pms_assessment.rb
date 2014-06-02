class PmsAssessment
  include Mongoid::Document
  field :kra_name, type: String
  field :moae, type: Integer
  field :moaa, type: Integer
  field :weightage, type: Integer
  field :feedback, type: String
  field :cr, type: Float
  field :sr, type: Float
  field :mr, type: Integer
  field :fr, type: Integer
  field :employee_id, type: String
  field :kra_id, type: String
  field :goal_id, type: String
end

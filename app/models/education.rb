class Education
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :marks, type: Float
  field :grade, type: String
  field :deleted, type: Boolean
  embedded_in :employee_detail
end

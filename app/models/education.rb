class Education
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :marks, type: Float
  field :grade, type: String
  field :erased, type: Boolean
  embedded_in :employee_detail
end

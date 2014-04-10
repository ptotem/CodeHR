class EmployeeQualification
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :institute, type: String
  field :university, type: String
  field :datefrom, type: Date
  field :dateto, type: Date
  field :marks, type: String
  field :grade, type: String
  embedded_in :employee_detail

end

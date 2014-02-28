class EmploymentHist
  include Mongoid::Document
  field :joined_from, type: Date
  field :leaved, type: Date
  field :organisation, type: String
  field :designation, type: String
  field :deleted, type: Boolean

  embedded_in :employee_detail
end

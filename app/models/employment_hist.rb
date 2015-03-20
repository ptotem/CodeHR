class EmploymentHist
  include Mongoid::Document
  include Mongoid::Timestamps
  field :joined_from, type: Date
  field :leaved, type: Date
  field :organisation, type: String
  field :designation, type: String
  field :erased, type: Boolean

  embedded_in :employee_detail
end

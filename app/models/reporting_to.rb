class ReportingTo
  include Mongoid::Document
  field :reporting_officer_id, type: String

  embedded_in :employee_master
end

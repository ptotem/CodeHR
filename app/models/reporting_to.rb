class ReportingTo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :reporting_officer_id, type: String
  field :deleted, type: Boolean
  embedded_in :employee_master
end

class DReport
  include Mongoid::Document
  field :report_date, type: Date
  field :reviewed_by, type: String
  field :cl_name, type: String
  field :cl_fields, type: Array
  field :object_hash, type: Array
  field :deleted, type: Boolean
end

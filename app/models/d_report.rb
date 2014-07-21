class DReport
  include Mongoid::Document
  include Mongoid::Timestamps
  field :report_date, type: Date
  field :reviewed_by, type: String
  field :cl_name, type: String
  field :cl_fields, type: Array
  field :object_hash, type: Array
  field :deleted, type: Boolean
  field :report_name, type: String

  has_many :report_query_statements
end

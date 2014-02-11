class DReport
  include Mongoid::Document
  field :report_date, type: Date
  field :reviewed_by, type: String
  field :object_hash, type: Array
end

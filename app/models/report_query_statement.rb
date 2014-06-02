class ReportQueryStatement
  include Mongoid::Document
  field :association, type: Array
  field :classname, type: String
  field :field, type: Array
  field :grp_by, type: Array
end

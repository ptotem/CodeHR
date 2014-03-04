class FamilyDetail
  include Mongoid::Document
  field :relationship, type: String
  field :fname, type: String
  field :mname, type: String
  field :lname, type: String
  field :deleted, type: Boolean
  embedded_in :employee_detail
end

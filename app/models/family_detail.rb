class FamilyDetail
  include Mongoid::Document
  field :relationship, type: String
  field :fname, type: String
  field :mname, type: String
  field :lname, type: String
  embedded_in :employee_master
end

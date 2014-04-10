class PfNomination
  include Mongoid::Document
  include Mongoid::Timestamps
  field :relationship, type: String
  field :sex, type: String
  field :dateofbirth, type: Date
  field :fname, type: String
  field :mname, type: String
  field :lname, type: String
  field :deleted, type: Boolean
  embedded_in :employee_detail
end

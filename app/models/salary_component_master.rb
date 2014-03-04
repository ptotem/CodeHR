class SalaryComponentMaster
  include Mongoid::Document
  field :name, type: String
  field :deleted, type: Boolean
end

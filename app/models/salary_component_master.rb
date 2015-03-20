class SalaryComponentMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :erased, type: Boolean
end

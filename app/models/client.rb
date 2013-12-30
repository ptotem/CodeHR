class Client
  include Mongoid::Document
  field :name, type: String
  field :address, type: String

  has_many :company_masters
end

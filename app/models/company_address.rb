class CompanyAddress
  include Mongoid::Document
  field :address1, type: String
  field :address, type: String
  field :city, type: String
  field :taluka, type: String
  field :district, type: String
  field :state, type: String
  field :country, type: String
  field :pin, type: String
  embedded_in :company_master
end

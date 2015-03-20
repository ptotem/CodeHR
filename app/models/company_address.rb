class CompanyAddress
  include Mongoid::Document
  include Mongoid::Timestamps
  field :address1, type: String
  field :address, type: String
  field :city, type: String
  field :taluka, type: String
  field :district, type: String
  field :state, type: String
  field :country, type: String
  field :pin, type: String
  field :erased, type: Boolean
  embedded_in :company_master
end

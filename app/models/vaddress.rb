class Vaddress
  include Mongoid::Document
  field :city, type: String
  field :state, type: String
  embedded_in :vendor_master
end

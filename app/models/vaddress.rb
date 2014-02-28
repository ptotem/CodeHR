class Vaddress
  include Mongoid::Document
  field :city, type: String
  field :state, type: String
  field :deleted, type: Boolean

  embedded_in :vendor_master
end

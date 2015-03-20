class Vaddress
  include Mongoid::Document
  include Mongoid::Timestamps
  field :city, type: String
  field :state, type: String
  field :erased, type: Boolean

  embedded_in :vendor_master
end

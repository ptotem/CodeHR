class CommunicationAddress
  include Mongoid::Document
  field :address1, type: String
  field :address2, type: String
  field :city, type: String
  field :taluka, type: String
  field :district, type: String
  field :state, type: String
  field :country, type: String
  field :zipcode, type: String
  embedded_in :candidate_master
end

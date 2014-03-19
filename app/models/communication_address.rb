class CommunicationAddress
  include Mongoid::Document
  include Mongoid::Timestamps
  field :address1, type: String
  field :address2, type: String
  field :city, type: String
  field :taluka, type: String
  field :district, type: String
  field :state, type: String
  field :country, type: String
  field :zipcode, type: String
  field :deleted, type: Boolean
  embedded_in :candidate_master
end

class ContactPerson
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :designation, type: String
  field :phone1, type: String
  field :phone2, type: String
  field :email, type: String
  field :deleted, type: Boolean
  embedded_in :vendor_master
end

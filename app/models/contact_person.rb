class ContactPerson
  include Mongoid::Document
  field :name, type: String
  field :designation, type: String
  field :phone1, type: String
  field :phone2, type: String
  embedded_in :vendor_master
end

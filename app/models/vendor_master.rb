class VendorMaster
  include Mongoid::Document
  field :vendor_code, type: String
  field :vendor_name, type: String
  field :vendor_type, type: String
  field :office_phone_number, type: String
  field :office_fax_number1, type: String
  field :office_fax_number2, type: String

  embeds_many :vaddresses
  embeds_many :contact_persons

  accepts_nested_attributes_for :vaddresses
  accepts_nested_attributes_for :contact_persons
end

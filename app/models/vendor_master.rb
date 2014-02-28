class VendorMaster
  include Mongoid::Document
  field :vendor_code, type: String
  field :vendor_name, type: String
  field :vendor_type, type: String
  field :office_phone_number, type: String
  field :office_fax_number1, type: String
  field :office_fax_number2, type: String
  field :deleted, type: Boolean

  embeds_many :vaddresses
  embeds_many :contact_persons

  accepts_nested_attributes_for :vaddresses
  accepts_nested_attributes_for :contact_persons

  validates :vendor_name, :presence => true
  validates :vendor_type, :presence => true
  validates :office_phone_number, :presence => true

  #TODO: validations for embedded fields

end

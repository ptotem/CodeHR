class CompanyMaster
  include Mongoid::Document
  field :company_code, type: String
  field :company_name, type: String
  field :office_phone_number, type: String
  field :office_fax_number_1, type: String
  field :office_fax_number_2, type: String
  field :vat_reg_number, type: String
  field :st_reg_Number, type: String
  field :pan_number, type: String
  field :pf_reg_number, type: String
  field :esic_reg_number, type: String
  field :remarks_1, type: String
  field :remarks_2, type: String
  field :remarks_3, type: String
  field :remarks_4, type: String
  field :remarks_5, type: String
  field :parent_company_ids, type: Array, default: []

  recursively_embeds_many
  has_many :company_addresses
  has_many :group_masters

  accepts_nested_attributes_for :company_addresses
  accepts_nested_attributes_for :group_masters

end

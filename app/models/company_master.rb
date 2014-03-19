class CompanyMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  #include CanCan::ModelAdditions::ClassMethods
  field :company_code, type: String
  field :company_name, type: String
  field :office_phone_number, type: String
  field :office_fax_number_1, type: String
  field :office_fax_number_2, type: String
  field :vat_reg_number, type: String
  field :st_reg_number, type: String
  field :pan_number, type: String
  field :pf_reg_number, type: String
  field :esic_reg_number, type: String
  field :remarks_1, type: String
  field :remarks_2, type: String
  field :remarks_3, type: String
  field :remarks_4, type: String
  field :remarks_5, type: String
  field :client_id, type: String
  field :deleted, type: Boolean
  #field :parent_company_ids, type: Array, default: []
  #field :child_company_master_ids, type: String
  #recursively_embeds_many

  embeds_many :company_addresses
  has_many :group_masters
  has_many :band_masters


  accepts_nested_attributes_for :company_addresses
  accepts_nested_attributes_for :group_masters

  accepts_nested_attributes_for :band_masters

  belongs_to :client

  rails_admin do
    navigation_label "Company Master"
  end

  #validates :company_code, :presence => true
  #
  #validates :company_name,
  #          :presence => true
  #
  #validates :company_addresses, :presence => true
  #
  #validates :office_phone_number,
  #          :presence => true
  #
  #validates :office_fax_number_1,
  #          :presence => true
  #
  #validates :pan_number, :presence => true

end

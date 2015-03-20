class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  field :company_group_code, type:String
  field :name, type: String
  field :address1, type: String
  field :address2, type: String
  field :city, type: String
  field :taluka, type: String
  field :district, type: String
  field :state, type: String
  field :country, type: String
  field :pin, type: String
  field :Phone1, type: String
  field :Phone2, type: String
  field :Fax, type: String
  field :email,type: String
  field :erased, type: Boolean
  has_and_belongs_to_many :notification_masters

  has_many :company_masters
  has_many :admin_users
  accepts_nested_attributes_for :company_masters
  accepts_nested_attributes_for :admin_users

end

class Client
  include Mongoid::Document
  field :name, type: String
  field :address, type: String
  field :email,type: String
  field :deleted, type: Boolean
  has_and_belongs_to_many :notification_masters

  has_many :company_masters
  has_many :admin_users
  accepts_nested_attributes_for :company_masters
  accepts_nested_attributes_for :admin_users

end

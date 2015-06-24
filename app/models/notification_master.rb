class NotificationMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code, type: String
  field :title, type: String
  field :description, type: String
  field :link, type: String
  field :link_title, type: String
  field :class_obj, type: String
  field :type, type: String
  field :read, type: Boolean, :default => false
  field :erased, type: Boolean
  belongs_to :document_template_master

  has_many :notification_details
  has_many :email_details

  has_and_belongs_to_many :users
  has_and_belongs_to_many :admin_users
  has_and_belongs_to_many :clients

  accepts_nested_attributes_for :notification_details
  accepts_nested_attributes_for :email_details
end

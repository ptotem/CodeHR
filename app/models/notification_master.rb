class NotificationMaster
  include Mongoid::Document
  field :code, type: String
  field :title, type: String
  field :description, type: String
  field :type, type: String
  belongs_to :document_template_master

  has_many :notification_details
  has_many :email_details

  accepts_nested_attributes_for :notification_details
  accepts_nested_attributes_for :email_details
end

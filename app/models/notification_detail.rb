class NotificationDetail
  include Mongoid::Document
  include Mongoid::Timestamps
  field :notification_master_id, type: Integer
  field :event, type: String
  field :sender, type: Integer
  field :erased, type: Boolean
  belongs_to :notification_master

  embeds_many :receivers
  accepts_nested_attributes_for :receivers
end

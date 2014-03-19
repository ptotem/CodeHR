class EmailDetail
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  field :notification_master_id, type: String
  field :event, type: String
  field :sender, type: String
  has_mongoid_attached_file :attachment1
  has_mongoid_attached_file :attachment2
  has_mongoid_attached_file :attachment3
  has_mongoid_attached_file :attachment4
  has_mongoid_attached_file :attachment5
  field :deleted, type: Boolean

  belongs_to :notification_master
  embeds_many :mail_tos
  embeds_many :mail_ccs
  embeds_many :mail_bccs
  belongs_to :notification_master
  accepts_nested_attributes_for :mail_tos
  accepts_nested_attributes_for :mail_ccs
  accepts_nested_attributes_for :mail_bccs

end

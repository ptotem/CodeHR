class DocumentTemplateMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  field :dt_code, type: String
  field :description, type: String
  field :related_to, type: String
  #field :file, type: Attachment
  has_mongoid_attached_file :dtfile
  field :deleted, type: Boolean

  has_many :document_masters
  has_many :notification_masters
  accepts_nested_attributes_for :document_masters
  accepts_nested_attributes_for :notification_masters
end

class MailCc
  include Mongoid::Document
  include Mongoid::Timestamps
  field :is_group, type: Boolean
  field :obj_id, type: String
  field :erased, type: Boolean
  embedded_in :email_detail
end

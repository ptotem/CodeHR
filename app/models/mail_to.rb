class MailTo
  include Mongoid::Document
  field :is_group, type: Boolean
  field :obj_id, type: String
  field :deleted, type: Boolean

  embedded_in :email_detail
end

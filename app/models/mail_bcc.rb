class MailBcc
  include Mongoid::Document
  field :is_group, type: Boolean
  field :obj_id, type: String
  embedded_in :email_detail
end

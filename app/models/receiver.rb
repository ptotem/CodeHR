class Receiver
  include Mongoid::Document
  field :name, type: String
  field :deleted, type: Boolean
  embedded_in :notification_detail
end

class Receiver
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :erased, type: Boolean
  embedded_in :notification_detail
end

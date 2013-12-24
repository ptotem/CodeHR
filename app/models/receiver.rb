class Receiver
  include Mongoid::Document
  field :name, type: String
  embedded_in :notification_detail
end

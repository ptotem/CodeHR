class UserTask
  include Mongoid::Document
  include Mongoid::Timestamps
  field :user_id, type: String
  field :title, type: String
  field :description, type: String
  field :link, type: String
  field :seen, type: Boolean
  field :erased, type: Boolean
  field :type, type: String
  belongs_to :user
end

class UserTask
  include Mongoid::Document
  field :user_id, type: String
  field :title, type: String
  field :description, type: String
  field :link, type: String
  field :seen, type: Boolean
  field :deleted, type: Boolean
  belongs_to :user
end

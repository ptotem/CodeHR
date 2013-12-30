class Role
  include Mongoid::Document
  field :name, type: String
  field :created_by_process, type: Boolean
  field :process_id, type: String
  belongs_to :user
end

class Resume
  include Mongoid::Document
  include Mongoid::Paperclip
  field :user_id, type: String

  has_mongoid_attached_file :file
end

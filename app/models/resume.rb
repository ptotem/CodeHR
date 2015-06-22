class Resume
  include Mongoid::Document
  include Mongoid::Paperclip


  has_mongoid_attached_file :file
end

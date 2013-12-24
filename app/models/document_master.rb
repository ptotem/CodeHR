class DocumentMaster
  include Mongoid::Document
  include Mongoid::Paperclip

  field :doc_code, type: String
  field :name, type: String
  field :vc_needed, type: Boolean
  field :owner, type: Integer
  has_mongoid_attached_file :dfile

  belongs_to :document_template_master
end

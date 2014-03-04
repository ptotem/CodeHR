class InterviewType
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :deleted, type: Boolean
  validates :description, :presence => true

end

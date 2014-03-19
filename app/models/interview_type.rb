class InterviewType
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :deleted, type: Boolean
  validates :description, :presence => true

end

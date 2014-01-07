class InterviewType
  include Mongoid::Document
  field :name, type: String
  field :description, type: String

  validates :description, :presence => true

end

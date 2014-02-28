class RatingScale
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :deleted, type: Boolean
  embeds_many :scales
  accepts_nested_attributes_for :scales

  #validates_associated :scales
  validates :description, :presence => true

end

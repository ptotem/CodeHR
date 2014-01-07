class Rating
  include Mongoid::Document
  field :comments, type: String
  embeds_many :score_receiveds
  has_many :dynamic_fields
  accepts_nested_attributes_for :score_receiveds

  belongs_to :vacancy_scheduling

  validates :comments, :presence => true
end

class ScoreReceived
  include Mongoid::Document
  #field :score, type: Integer
  field :rating_scale_id, type: String

  embedded_in :rating
  embeds_many :rating_measures
  accepts_nested_attributes_for :rating_measures
end

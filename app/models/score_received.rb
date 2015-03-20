class ScoreReceived
  include Mongoid::Document
  include Mongoid::Timestamps
  #field :score, type: Integer
  field :rating_scale_id, type: String
  field :sr_name, type: String
  field :erased, type: Boolean
  field :total_score, type: Integer
  embedded_in :rating
  embeds_many :rating_measures
  accepts_nested_attributes_for :rating_measures
end

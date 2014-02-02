class ScoreReceived
  include Mongoid::Document
  field :score, type: Integer
  field :rating_scale_id, type: String
end

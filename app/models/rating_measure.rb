class RatingMeasure
  include Mongoid::Document
  field :name, type: String
  field :priority, type: Integer
  field :range_from, type: String
  field :range_to, type: String
  field :score, type: String
  field :deleted, type: Boolean
  embedded_in :score_received
end

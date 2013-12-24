class Scale
  include Mongoid::Document
  field :scale_description, type: String
  field :range_from, type: String
  field :range_to, type: String
  embedded_in :rating_scale
end

class Scale
  include Mongoid::Document
  include Mongoid::Timestamps
  field :scale_name, type: String
  field :scale_description, type: String
  field :priority, type: Integer
  field :range_from, type: String
  field :range_to, type: String
  field :deleted, type: Boolean
  embedded_in :rating_scale
end

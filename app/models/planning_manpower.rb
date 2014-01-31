class PlanningManpower
  include Mongoid::Document
  field :group, type: String
  field :band, type: String
  field :position, type: String
  field :position_nature, type: String
  field :ff_source, type: String
  field :location, type: String
  field :supervisor, type: String
  field :comments, type: String
end

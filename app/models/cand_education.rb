class CandEducation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :marks, type: String
  field :grade, type: String
  field :erased, type: Boolean
  embedded_in :candidate_master
end

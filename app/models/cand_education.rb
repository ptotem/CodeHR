class CandEducation
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :marks, type: String
  field :grade, type: String
  field :deleted, type: Boolean
  embedded_in :candidate_master
end

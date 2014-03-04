class CandidateContactNumber
  include Mongoid::Document
  field :home, type: String
  field :mobile, type: String
  field :office, type: String
  field :deleted, type: Boolean
  embedded_in :candidate_master
end

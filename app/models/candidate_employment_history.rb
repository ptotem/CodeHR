class CandidateEmploymentHistory
  include Mongoid::Document
  field :joined_from, type: Date
  field :leaved, type: Date
  field :organisation, type: String
  field :designation, type: String
  embedded_in :candidate_master
end

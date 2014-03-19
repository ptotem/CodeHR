class CandidateEmploymentHistory
  include Mongoid::Document
  include Mongoid::Timestamps
  field :joined_from, type: Date
  field :leaved, type: Date
  field :organisation, type: String
  field :designation, type: String
  field :deleted, type: Boolean
  embedded_in :candidate_master
end

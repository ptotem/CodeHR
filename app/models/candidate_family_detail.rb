class CandidateFamilyDetail
  include Mongoid::Document
  field :relaationship, type: String
  field :fname, type: String
  field :mname, type: String
  field :lname, type: String
  embedded_in :candidate_master
end

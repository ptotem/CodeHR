class CandidateFamilyDetail
  include Mongoid::Document
  include Mongoid::Timestamps
  field :relaationship, type: String
  field :sex, type: String
  field :dateofbirth, type: Date
  field :fname, type: String
  field :mname, type: String
  field :lname, type: String
  field :erased, type: Boolean
  embedded_in :candidate_master
end

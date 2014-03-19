class JobPreference
  include Mongoid::Document
  include Mongoid::Timestamps
  field :vacancy_id, type: String
  field :deleted, type: Boolean
  embedded_in :candidate_master
end

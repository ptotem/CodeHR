class JobPreference
  include Mongoid::Document
  field :vacancy_id, type: String
  embedded_in :candidate_master
end

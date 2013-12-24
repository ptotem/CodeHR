class LocationPreference
  include Mongoid::Document
  field :name, type: String
  embedded_in :candidate_master
end

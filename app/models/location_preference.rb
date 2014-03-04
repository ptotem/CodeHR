class LocationPreference
  include Mongoid::Document
  field :name, type: String
  field :deleted, type: Boolean
  embedded_in :candidate_master
end

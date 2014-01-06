class BandMaster
  include Mongoid::Document
  field :band_code, type: String
  field :band_name, type: String

  embedded_in :company_master
end

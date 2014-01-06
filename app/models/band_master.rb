class BandMaster
  include Mongoid::Document
  field :band_code, type: String
  field :band_name, type: String

  belongs_to :company_master
end

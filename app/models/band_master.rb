class BandMaster
  include Mongoid::Document
  field :band_code, type: String
  field :band_name, type: String
  field :deleted, type: Boolean

  belongs_to :company_master
end

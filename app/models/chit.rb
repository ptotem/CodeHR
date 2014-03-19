class Chit
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :ocname, type: String
  field :oid, type: String
  field :deleted, type: Boolean

  embedded_in :process_tr
end

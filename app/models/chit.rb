class Chit
  include Mongoid::Document
  field :name, type: String
  field :ocname, type: String
  field :oid, type: String

  embedded_in :process_tr
end

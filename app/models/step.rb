class Step
  include Mongoid::Document
  field :name, type: String
  field :deleted, type: Boolean
  embedded_in :process_master
end

class Step
  include Mongoid::Document
  field :name, type: String
  embedded_in :process_master
end

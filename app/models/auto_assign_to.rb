class AutoAssignTo
  include Mongoid::Document
  field :oclass, type: String
  field :dclass, type: String
  field :objid, type: String

  embedded_in :step_master
end

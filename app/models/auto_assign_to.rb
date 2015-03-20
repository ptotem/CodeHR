class AutoAssignTo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :oclass, type: String
  field :dclass, type: String
  field :objid, type: String
  field :erased, type: Boolean

  embedded_in :step_master
end

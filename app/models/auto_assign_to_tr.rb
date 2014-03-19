class AutoAssignToTr
  include Mongoid::Document
  include Mongoid::Timestamps
  field :aclass, type: String
  field :dclass, type: String
  field :objid, type: String
  field :deleted, type: Boolean
  embedded_in :step_tr
end

class AutoAssignToTr
  include Mongoid::Document
  field :aclass, type: String
  field :dclass, type: String
  field :objid, type: String
  embedded_in :step_tr
end

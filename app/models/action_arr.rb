class ActionArr
  include Mongoid::Document
  include Mongoid::Timestamps
  field :a_cls_name, type: String
  field :dep_clas_name, type: String
  field :obj_id, type: String
  field :deleted, type: Boolean

  embedded_in :step_tr
end

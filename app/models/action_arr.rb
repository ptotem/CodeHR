class ActionArr
  include Mongoid::Document
  field :a_cls_name, type: String
  field :dep_clas_name, type: String
  field :obj_id, type: String

  embedded_in :step_tr
end

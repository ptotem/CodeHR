class ActionArrMaster
  include Mongoid::Document
  field :a_class_name, type: String
  field :dep_class_name, type: String
  field :a_obj_id, type: String

  embedded_in :step_master
end

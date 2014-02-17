class MasterStep
  include Mongoid::Document
  field :step_name, type: String
  field :action, type: String
  field :action_class, type: String
  field :auto, type: Boolean
  field :action_parameter, type: Array
  belongs_to :master_pro
end
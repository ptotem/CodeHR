class MasterStep
  include Mongoid::Document
  include Mongoid::Timestamps
  field :step_name, type: String
  field :sequence, type: Integer
  field :action, type: String
  field :action_class, type: String
  field :action_obj, type: String
  field :auto, type: Boolean
  field :action_parameter, type: Array
  field :params_mapping, type: Hash
  field :approval_obj, type: Hash
  field :notification_obj, type: Hash
  field :deleted, type: Boolean
  field :repeat_on, type: String
  belongs_to :master_pro
end
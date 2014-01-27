class ProcessMasterApproval
  include Mongoid::Document

  field :action_day, type: String
  field :action_hour, type: String
  field :action_min, type: String
  field :repeat, type: boolean
  field :repeat_day, type: String
  field :repeat_hour, type: String
  field :repeat_min, type: String

  #embedded_in :process_master
  embedded_in :step_master
end

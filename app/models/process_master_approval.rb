class ProcessMasterApproval
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action_day, type: String
  field :action_hour, type: String
  field :action_min, type: String
  #field :repeat, type: boolean
  field :repeat_day, type: String
  field :repeat_hour, type: String
  field :repeat_min, type: String
  field :erased, type: Boolean

  #embedded_in :process_master
  embedded_in :step_master
end

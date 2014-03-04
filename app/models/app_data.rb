class AppData
  include Mongoid::Document
  field :approve_step, type: String
  field :reject_step, type: String
  field :reminder, type: String
  field :rep_reminder, type: String
  field :escalate, type: String
  field :rem_escalate, type: String
  field :deleted, type: Boolean

  #embedded_in :step_master
  #embeds_many :auto_assign_tos
  #accepts_nested_attributes_for :auto_assign_tos
end

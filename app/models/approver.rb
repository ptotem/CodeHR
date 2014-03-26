class Approver
  include Mongoid::Document
  include Mongoid::Timestamps
  field :employee_master_id, type: String
  field :approved, type: Boolean
  field :rejected, type: Boolean
  field :escalated, type: Boolean
  field :escalated_from, type: String
  field :active, type: Boolean
  field :auto_assign, type: Boolean
  field :is_approver, type: Boolean
  field :deleted, type: Boolean
  field :comment, type: String
  field :finished_at , type: DateTime
  embedded_in :approval_mat
end

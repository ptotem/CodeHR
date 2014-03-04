class Approver
  include Mongoid::Document
  field :employee_master_id, type: String
  field :approved, type: Boolean
  field :escalated, type: Boolean
  field :escalated_from, type: String
  field :active, type: Boolean
  field :auto_assign, type: Boolean
  field :deleted, type: Boolean
  embedded_in :approval_mat
end

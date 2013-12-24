class ApprovalMat
  include Mongoid::Document
  field :employee_master_id, type: String

  embedded_in :manpower_planning
end

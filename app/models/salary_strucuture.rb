class SalaryStrucuture
  include Mongoid::Document
  include Mongoid::Timestamps
  field :vacancy_master_id, type: String
  field :candidate_master_id, type: String
  field :erased, type: Boolean

end

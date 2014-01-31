class SalaryStrucuture
  include Mongoid::Document
  field :vacancy_master_id, type: String
  field :candidate_master_id, type: String


end

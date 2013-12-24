class CompensationComponent
  include Mongoid::Document
  field :final_ctc_fixed, type: Integer
  field :final_ctc_varriable, type: Integer
  belongs_to :vacancy_master

  embeds_many :formula_lists
  accepts_nested_attributes_for :formula_lists
end

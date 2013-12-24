class GroupMaster
  include Mongoid::Document
  field :group_code, type: String
  field :group_name, type: String
  field :compnany_id, type: Integer
  recursively_embeds_many
  belongs_to :company_master
  has_many :manpower_plannings
  has_many :vacancy_masters
  accepts_nested_attributes_for :manpower_plannings
  accepts_nested_attributes_for :vacancy_masters
end

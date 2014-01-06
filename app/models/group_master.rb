class GroupMaster
  include Mongoid::Document
  field :group_code, type: String
  field :group_name, type: String
  field :created_by_process, type: Boolean
  field :process_id, type: String
  field :company_master_id, type: String
  field :child_group_master_ids, type: Array
  recursively_embeds_many
  belongs_to :company_master
  has_many :manpower_plannings
  has_many :vacancy_masters
  has_many :employee_masters

  has_many :child_groups, :class_name => 'GroupMaster', :inverse_of => :parent_group
  belongs_to :parent_group, :class_name => 'GroupMaster', :inverse_of => :child_group

  #accepts_nested_attributes_for :parent_group
  accepts_nested_attributes_for :manpower_plannings
  accepts_nested_attributes_for :vacancy_masters
  accepts_nested_attributes_for :employee_masters
end

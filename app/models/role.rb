class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :created_by_process, type: Boolean
  field :process_id, type: String
  field :deleted, type: Boolean
  #field :employee_master_ids, type: Array

  belongs_to :employee_master
  has_many :employee_masters
  #accepts_nested_attributes_for :employee_masters

  belongs_to :user
end

class PmsSubgroup
  include Mongoid::Document
  field :name, type: String
  field :percentage, type: Integer
  field :linked_to, type: String
  belongs_to :pms_group_category

  has_many :pms_kra_kpi_tabs
  accepts_nested_attributes_for :pms_kra_kpi_tabs
end

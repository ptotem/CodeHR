class PmsKraKpiTab
  include Mongoid::Document
  field :kra, type: String
  field :objorsub, type: Integer
  field :unit, type: String
  field :kpi_range1, type: String
  field :kpi_range2, type: String
  field :kpi_range3, type: String
  field :kpi_range4, type: String
  field :kpi_range5, type: String
  field :percentage, type: Integer
  field :linked_to, type: String

  belongs_to :pms_subgroup
end

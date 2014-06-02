class Goal
  include Mongoid::Document
  field :code, type: String
  field :name, type: String
  field :period_from,  type: String
  field :period_to,  type: String
  field :obj_class, type: String
  field :obj_id, type: String
  field :calculated_rating, type: Integer
  # recursively_embeds_many
  has_many :kras
  accepts_nested_attributes_for :kras

  # Relationships
  has_and_belongs_to_many :subgoals, :inverse_of => :parents,  :class_name => 'Goal', :autosave => true
  has_and_belongs_to_many :parents,  :inverse_of => :subgoals, :class_name => 'Goal', :autosave => true
  accepts_nested_attributes_for :subgoals

end

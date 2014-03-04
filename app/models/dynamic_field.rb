class DynamicField
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :oclass, type: String
  field :deleted, type: Boolean

  belongs_to :rating
end

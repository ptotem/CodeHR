class AbilityMatrix
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :role_id, type: String
  field :access_obj, type: Array
  field :master_pro_id, type: String
  field :deleted, type: Boolean
end

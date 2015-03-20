class AbilityMatrix
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :role_id, type: Array
  field :access_obj, type: Array
  field :master_pro_id, type: String
  field :erased, type: Boolean
end

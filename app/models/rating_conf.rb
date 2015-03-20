class RatingConf
  include Mongoid::Document
  include Mongoid::Timestamps
  field :col_name, type: String
  field :col_lable, type: String
  field :col_validation, type: Boolean
  field :col_type, type: String
  field :col_sequence, type: Integer
  field :col_show, type:Boolean
  field :is_model, type: Boolean
  field :is_nested , type: Boolean
  field :type, type: String
  field :parent, type: String
  field :erased, type: Boolean
end

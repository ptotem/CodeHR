class Qualification
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :marks, type: String
  field :grade, type: String
  field :deleted, type: Boolean
  embedded_in :job_description_master
end

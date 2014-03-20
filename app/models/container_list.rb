class ContainerList
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action_type, type: String
  field :link, type: String

end

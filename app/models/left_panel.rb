class LeftPanel
  include Mongoid::Document

  field :name, type: String
  field :label_processs_name, type: String

  field :process_obj, type: Array
  field :label_process_obj, type: String

  field :report_obj, type: Array
  field :label_report_obj, type: String

  field :doc_obj, type: Array
  field :label_doc_obj, type: String
end

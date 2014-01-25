class DocumentMaster
  include Mongoid::Document
  include Mongoid::Paperclip

  field :doc_code, type: String
  field :name, type: String
  field :vc_needed, type: Boolean
  field :owner, type: Integer
  has_mongoid_attached_file :dfile

  belongs_to :document_template_master
end
#EmployeeMaster.fields.keys|EmployeeDetail.fields.keys
#EmployeeDetail.reflections.values.map{|i| i.class_name}
#EmployeeDetail.reflections.values.map{|i| eval(i.class_name)}
#EmployeeDetail.reflections.values.map{|i| eval(i.class_name).fields.keys}
#EmployeeDetail.reflections.values.map{|i| eval(i.class_name).fields.keys}.flatten!
#EmployeeDetail.reflections.values.map{|i| eval(i.class_name).fields.keys}.flatten! + EmployeeDetail.fields.keys
#EmployeeDetail.reflections.values.map{|i| eval(i.class_name).fields.keys}.flatten! | EmployeeDetail.fields.keys
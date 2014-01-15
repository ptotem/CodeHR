class ApprovalMat
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :link, type: String
  field :finished, type: Boolean
  field :process_tr_id, type: String
  field :step_no, type: Integer
  embeds_many :approvers
  accepts_nested_attributes_for :approvers
  belongs_to :process_tr


  #after creation of Approval send notification and email to all the approvers.

  def send_notification
    self.approvers.each do |aa|
      @approver=User.find(aa.employee_master_id)
      unm=@approver.notification_masters.build title:self.name , description:self.description,  type:"Approval"
      unm.save
      unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
      unm.email_details.build(:notification_master_id => unm._id,:event=>content)
      unm.save
      @client.save
      AdminMailer.admin_mail(@client.email,"#{oclass} #{oaction}","#{content}").deliver
      puts "Client mail delivered"
    end
  end
end
class Kra
  include Mongoid::Document
  field :kra_code, type: String
  field :kra_name, type: String
  field :kpi_value, type: Integer
  field :kpi_description, type: String
  field :incremental, type: Boolean
  field :unit, type: String
  field :weightage, type: String
  field :average_rating, type: Integer
  field :linked_to_group, type: Array
  field :linked_to_kra, type: Array

  has_and_belongs_to_many :subkras, :inverse_of => :parents,  :class_name => 'Kra', :autosave => true
  has_and_belongs_to_many :parents,  :inverse_of => :subkras, :class_name => 'Kra', :autosave => true
  accepts_nested_attributes_for :subkras
  # recursively_embeds_many

  belongs_to :goal

  after_save :notify_related_kra

  def notify_related_kra
    puts "happening.."
    if !self.linked_to_kra.nil?
    self.linked_to_kra.to_a.each do |i|
      puts "-------"
      puts Kra.find(i).goal.obj_id
      puts Kra.find(i).goal.obj_class
      if Kra.find(i).goal.obj_class == "EmployeeMaster"
        user=EmployeeMaster.find(Kra.find(i).goal.obj_id).user
        unm=user.notification_masters.build title:"Kra #{self.kra_name} updated" , description:"Kra #{self.kra_name} updated. Please make corresponding changes",  type:"test1", read: false
        unm.save
        unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
        unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
        unm.save
        user.save
      elsif Kra.find(i).goal.obj_class == "GroupMaster"
        # @users=EmployeeMaster.where(:group_master_id => Kra.find(i).goal.obj_id)

        @users=EmployeeMaster.all.select{ |i| i.group_master_ids.include?(GroupMaster.find(Kra.find(i).goal.obj_id).id)}
        @users.each do |user|
          @user = user.user
          unm=user.notification_masters.build title:"Kra #{self.kra_name} updated" , description:"Kra #{self.kra_name} updated. Please make corresponding changes",  type:"test1", read: false
          unm.save
          unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
          unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
          unm.save
          @user.save
        end
      elsif Kra.find(i).goal.obj_class == "Role"
        @users=Role.find(Kra.find(i).goal.obj_id).employee_masters
        @users.each do |user|
          @user = user.user
          unm=user.notification_masters.build title:"Kra #{self.kra_name} updated" , description:"Kra #{self.kra_name} updated. Please make corresponding changes",  type:"test1", read: false
          unm.save
          unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
          unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
          unm.save
          @user.save
        end
      end

    end
    end
  end

  def avg_rat(user_id)
    @e = EmployeeMaster.find(user_id)
    return PmsAssessment.where(:employee_id => @e.id, :kra_id => self.id).first.cr
  end

end

# if @pro.notification_obj["oClass"] == "EmployeeMaster"
#   puts "------------------Employee----------------------------"
#   if !@pro.notification_obj["action_arr"].nil?
#     puts @pro.notification_obj["action_arr"]
#     @pro.notification_obj["action_arr"].each do |noti|
#       # puts "000000000000000000000000000000000000000000000---"+noti["id"]+"---000000000000000000000000000000000000000000000"
#       user=EmployeeMaster.find(noti["id"]).user
#       puts user
#       unm=user.notification_masters.build title:@pro.notification_obj["title"] , description:@pro.notification_obj["description"],  type:"test1", read: false
#       unm.save
#       unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
#       unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
#       unm.save
#       user.save
#     end
#   end
# elsif @pro.notification_obj["oClass"] == "GroupMaster"
#   @pro.notification_obj["action_arr"].each do |noti|
#     @users=EmployeeMaster.where(:group_master_id => noti["id"])
#     @users.each do |user|
#       @user = user.user
#       unm=@user.notification_masters.build title:"System Notification" , description:"Notification Description",  type:"test1", read: false
#       unm.save
#       unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
#       unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
#       unm.save
#       @user.save
#     end
#   end
# elsif @pro.notification_obj["oClass"] == "Role"
#   @pro.notification_obj["action_arr"].each do |noti|
#     @users=EmployeeMaster.where(:role_id => noti["id"])
#     @users.each do |user|
#       @user = user.user
#       unm=@user.notification_masters.build title:"System Notification" , description:"Notification Description",  type:"test1", read: false
#       unm.save
#       unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
#       unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
#       unm.save
#       @user.save
#     end
#   end
# elsif @pro.notification_obj["oClass"] == "VendorMaster"
#   @pro.notification_obj["action_arr"].each do |noti|
#     @user= VendorMaster.find(noti["id"]).user
#     puts @user
#     unm=@user.notification_masters.build title:"System Notification" , description:"Notification Description",  type:"test1", read: false
#     unm.save
#     unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
#     unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
#     unm.save
#     @user.save
#   end
# end
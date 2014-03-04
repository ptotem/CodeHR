class ProcessTr
  include Mongoid::Document
  field :code, type: String
  field :name, type: String
  field :user_id, type: String
  field :loop_step, type: String
  field :deleted, type: Boolean

  embeds_many :step_trs
  embeds_many :chits
  has_many :approval_mats

  accepts_nested_attributes_for :step_trs
  accepts_nested_attributes_for :chits
  accepts_nested_attributes_for :approval_mats

  state_machine :state, initial: :created do

    after_transition :dispense_soda => :complete, :do => :manage_stock

    after_transition :created => :initiate, :do => :init_process

    after_transition :initiate => :processing, :do => :post_operating_process

    after_transition :processing => :finished, :do => :post_finish_process

    event :button_press do
      transition :awaiting_selection => :dispense_soda, if: :in_stock?
    end

    event :initialise_process do
      transition :created => :initiate

    end

    event :start_processing do
      transition :initiate => :processing
    end

    event :end_processing do

      transition :processing => :finished
    end

  end

  def button_press(selection)
    @selection = selection
    super
  end

  def manage_stock
    puts "Removing 1 from the #{@selection} count"
  end

  def in_stock?
    stock_levels[@selection] > 0
  end

  def stock_levels
    {
        dr_pepper: 100,
        sprite: 10,
        root_beer: 0,
        cola: 8
    }
  end

  def load_process
    puts "Step is loading....."
    self.initialise_process
  end

  def init_process
    puts "Initialise step...."
    puts "Step is initialised...."
    puts "Step is preparing to be processed"
    self.start_processing
  end

  def post_operating_process
    puts "step is processing.."
    puts "Step is preparing for finish processing"
    #self.end_processing
    self.step_trs.first.load_step
  end

  def post_finish_process
    puts "Process is finished"
    @notified= Array.new
    @groups= Array.new
    @creator =User.find(self.user_id)#.employee_master

    @notified = self.step_trs.select{|i| i.oaction =="Notify"}.map{|i| i.action_arrs.select{|j| j.a_cls_name=="EmployeeMaster"}.map{|k| k.obj_id}}.flatten! rescue []
    @groups = self.step_trs.select{|i| i.oaction =="Notify"}.map{|i| i.action_arrs.select{|j| j.a_cls_name=="GroupMaster"}}.flatten! rescue []
    if !@groups.nil?
    if @groups.count>0
      @groups.each do |i|
        @notified << EmployeeMaster.where(:group_master_id => i).first.user_id
      end
    end
    end
    @notified << @notified.flatten! rescue []
    @notified << @creator.employee_master._id rescue self.user_id
    @notified << ApprovalMat.where(:process_tr_id=>self._id).map{|i| i.approvers.map{|i| i.employee_master_id}}.flatten!.uniq rescue []
    @notified = @notified.flatten.compact.uniq rescue []
    @notified.each do |noti|
      EmployeeMaster.find(noti).user.notification_masters.create!(:title => "#{self.name} is Finished" ,:description => "This process hass finished processing.",read:false)
      AdminMailer.admin_mail(EmployeeMaster.find(noti).user.email,"#{self.name} is Finished","This process is finished processing.")
    end
    puts "Notification Sent to everyone...."
  end

  def finish_process
    puts "###################################################"
    self.end_processing
  end

  def load_next_step(counter)
    puts "Loading next steps of process..."
    self.step_trs[counter].load_step
  end

end

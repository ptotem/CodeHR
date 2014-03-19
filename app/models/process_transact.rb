class ProcessTransact
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  field :name, type: String
  field :mp_name, type: String
  field :parameter, type: Hash
  field :cobject_id,type: String
  field :user_id,type: String
  field :created_by,type: String
  field :facilitated_by,type: String
  field :class_obj, type: Hash
  field :app_obj, type: Hash
  field :notification_obj, type: Hash
  field :created_by_process, type: Boolean
  field :dependent, type: Boolean
  field :parent_pro_id, type: String
  field :parent_step_no, type: Integer
  has_mongoid_attached_file :bulk_data
  field :deleted, type: Boolean

  embeds_many :step_transacts
  accepts_nested_attributes_for :step_transacts


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
    self.step_transacts.first.load_step
    #self.finish_process
  end

  def post_finish_process
    puts "Process is finished"
    puts "Notification Sent to everyone...."
    if created_by_process
      if !self.dependent.nil?
        if self.dependent
          @parent_pro = ProcessTransact.find(self.parent_pro_id)
          puts "Child Process has ended now resuming back to parent process"
          @parent_pro.step_transacts[self.parent_step_no.to_i].end_processing_step
        end
      end
    end
  end

  def finish_process
    puts "###################################################"
    self.end_processing
  end

  def load_next_step(counter)
    puts "Loading next steps of process..."
    self.step_transacts[counter].load_step
  end

end

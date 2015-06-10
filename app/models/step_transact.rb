class StepTransact
  include Mongoid::Document
  include AASM
  include Mongoid::Timestamps
  include ApplicationHelper
  field :name, type: String
  field :action_name, type: String
  field :action_object_id, type: String
  field :obj_name, type: String
  field :action_obj, type: String
  field :auto, type: Boolean
  field :params_mapping, type: Hash
  field :erased, type: Boolean
  field :initiated_at, type: DateTime
  field :finished_at, type: DateTime
  field :repeat_on, type: String
  field :state, type: String
  embedded_in :process_transact

  #--------------------------------------------------------------
  #Added on: 19/02/2015
  #Statemachine gem stop working in rails 4.1
  #--------------------------------------------------------------

  aasm do
    state :created, :initial => true
    state :initiate
    state :processing
    state :finished

    event :initialise_step, :after => :init_step do
      transitions :from => :created, :to => :initiate
    end

    event :start_processing_step, :after => :post_process_step do
      transitions :from =>:initiate, :to => :processing
    end

    event :end_processing_step, :after => :post_finish_step do
      transitions :from => :processing, :to => :finished
    end
  end

  # TODO: To be removed later.
  # state_machine :state, initial: :created do
  #
  #   after_transition :dispense_soda => :complete, :do => :manage_stock
  #
  #   after_transition :created => :initiate, :do => :init_step
  #
  #   after_transition :initiate => :processing, :do => :post_process_step
  #
  #   after_transition :processing => :finished, :do => :post_finish_step
  #
  #   event :button_press do
  #     transition :awaiting_selection => :dispense_soda, if: :in_stock?
  #   end
  #
  #   event :initialise_step do
  #     transition :created => :initiate
  #
  #   end
  #
  #   event :start_processing_step do
  #     transition :initiate => :processing
  #   end
  #
  #   event :end_processing_step do
  #
  #     transition :processing => :finished
  #   end
  #
  # end

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

  def aasm_state
    self[:aasm_state] || "created"
  end

  def stock_levels
    {
        dr_pepper: 100,
        sprite: 10,
        root_beer: 0,
        cola: 8
    }
  end

  def load_step
    puts "#{self.name} is loading....."
    self.initiated_at = DateTime.now
    self.initialise_step
  end

  def init_step
    puts "Initialise step...."
    puts "#{self.name} initialised...."
    puts "#{self.name} preparing to be processed"
    self.start_processing_step
  end

  def post_process_step
    puts "#{self.name} is processing.."
    puts "#{self.name} is preparing for finish processing"
    self.process_transact.save
    puts "----------------------------------------------"
    puts "Current Step State : "+self.aasm_state
    puts "----------------------------------------------"
    #self.end_processing_step
    #step_processing(self.oclass,self.oaction,self.action_to,self.content,self.process_tr._id,self.process_tr.step_trs.index(self),self.process_tr.user_id)
    step_transaction_processing(self.action_name,self.obj_name,self.process_transact.cobject_id, self.action_obj,self.process_transact._id, self.process_transact.step_transacts.index(self),self.process_transact.user_id)
  end

  def post_finish_step
    puts "#{self.name} is finished"
    self.finished_at = DateTime.now
    self.save
    puts "Calling Next step action or ending process to be done...."
    if self==self.process_transact.step_transacts.last
      puts "Last step going to end process"
      self.process_transact.finish_process
    else
      puts "Initialising next steps"
      self.process_transact.load_next_step(self.process_transact.step_transacts.index(self)+1)
    end
  end

end

class StepMaster
  include Mongoid::Document
  field :name, type: String
  field :oclass, type: String
  field :oaction, type: String
  field :action_to, type: String
  field :content, type: String
  field :sequence, type: Integer

  embeds_many :action_arr_masters

  embedded_in :process_master

  accepts_nested_attributes_for :action_arr_masters

  state_machine :state, initial: :created do

    after_transition :dispense_soda => :complete, :do => :manage_stock

    after_transition :created => :initiate, :do => :init_step

    after_transition :initiate => :processing, :do => :post_process_step

    after_transition :processing => :finished, :do => :post_finish_step

    event :button_press do
      transition :awaiting_selection => :dispense_soda, if: :in_stock?
    end

    event :initialise_step do
      transition :created => :initiate

    end

    event :start_processing_step do
      transition :initiate => :processing
    end

    event :end_processing_step do

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

  def load_step
    puts "#{self.name} is loading....."
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
    self.end_processing_step
  end

  def post_finish_step
    puts "#{self.name} is finished"
    puts "Calling Next step action or ending process to be done...."
    if self==self.process_master.step_masters.last
      puts "Last step going to end process"
      self.process_master.finish_process
    else
      puts "Initialising next steps"
      self.process_master.load_next_step(self.process_master.step_masters.index(self)+1)
    end
  end



end

class StepTr
  include Mongoid::Document
  include ApplicationHelper

  field :name, type: String
  field :oclass, type: String
  field :oaction, type: String
  field :action_to, type: String
  field :content, type: String
  embedded_in :process_tr

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
    #redirect_to "/roles/new"
    #redirect_to "/"
    #self.end_processing_step
    #ProcessTr.navigate
    #"/roles/new"
    step_processing(self.oclass,self.oaction,self.action_to,self.content,self.process_tr._id,self.process_tr.step_trs.index(self),self.process_tr.user_id)
    #call_redirect
  end

  def post_finish_step
    puts "#{self.name} is finished"
    puts "Calling Next step action or ending process to be done...."
    if self==self.process_tr.step_trs.last
      puts "Last step going to end process"
      self.process_tr.finish_process
    else
      puts "Initialising next steps"
      self.process_tr.load_next_step(self.process_tr.step_trs.index(self)+1)
    end
  end

end

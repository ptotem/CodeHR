class ProcessMaster
  include Mongoid::Document
  field :name, type: String
  embeds_many :steps
  accepts_nested_attributes_for :steps

  state_machine :state, initial: :awaiting_selection do

    after_transition :dispense_soda => :complete, :do => :manage_stock

    event :button_press do
      transition :awaiting_selection => :dispense_soda, if: :in_stock?
    end

    event :soda_dropped do
      transition :dispense_soda => :complete
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

end

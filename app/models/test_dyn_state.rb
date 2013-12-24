class TestDynState

  attr_accessor :state

  # Make sure the machine gets initialized so the initial state gets set properly
  def initialize(*)
    super
    machine
  end

  def transitions
    [
        {:parked => :idling, :on => :ignite},
        {:idling => :first_gear, :first_gear => :second_gear, :on => :shift_up}          ,
    {[:idling, :first_gear] => :parked, :on => :park,:before_transition=>"puts 'some'"},
        #{:before_transition=> {:from => :parked, :except_to => :parked, :do => :put_on_seatbelt  }}

    ]
  end
  def machine
    vehicle = self
    @machine ||= Machine.new(vehicle, :initial => :parked, :action => :save) do
      vehicle.transitions.each {|attrs| transition(attrs)}
    end
  end
  def savealt
    puts "savealt"
  end
  def save
    puts "save"
    # Save the state change...
    true
  end

  #def ignite
  #  true
  #
  #end
  def put_on_seatbelt
    puts "this is seatbelt"
  end
  def cnd
    true
  end

end


class Machine
  def self.new(object, *args, &block)
    machine_class = Class.new
    machine = machine_class.state_machine(*args, &block)
    attribute = machine.attribute
    action = machine.action

    # Delegate attributes
    machine_class.class_eval do
      define_method(:definition) { machine }
      define_method(attribute) { object.send(attribute) }
      define_method("#{attribute}=") {|value| object.send("#{attribute}=", value) }
      define_method(action) { object.send(action) } if action
    end

    machine_class.new
  end



end
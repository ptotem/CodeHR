 require 'wongi-engine'

class CustomRule
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :subject
  field :predicate
  field :object
  field :erased, type: Boolean
  embeds_one :custom_condition
  accepts_nested_attributes_for :custom_condition

  embeds_many :rule_actions
  accepts_nested_attributes_for :rule_actions

  after_save :add_engine_rule

  def add_engine_rule
    @rule=self
    @rule_name=self.name
    rule_obj = self.object
    rule_subj = self.subject
    rule_actions = self.rule_actions.all

    puts rule_actions.map { |i| i.obje }
    puts rule_obj + ":" + rule_subj

    $rule_engine.rule "#{@rule_name}" do
      forall {
        has :Subjected_from, :Check_predicate, :Objected_to
        assert :Subjected_from, :Check_predicate, :Objected_to do |subj, pred, obj|
          $current_obj = obj.split('|')[1]
          $current_obj_id = obj.split('|')[2]

          $current_sub = subj.split('|')[1]
          $current_sub_id = subj.split('|')[2]

          obj.split('|')[0].include? rule_obj
          rule_subj.include? subj.split('|')[0]
          #true
          #puts "check"
        end
      }
      make {
        action { |token|
          puts "Action of rule testing"
          rule_actions.each do |action|
            eval_string = "ActionToTake.new." + action.funct.downcase + "(['" + action.obje.to_s + "','" + $current_obj.to_s + "','" + $current_obj_id.to_s + "'])"
            puts eval_string
            instance_eval(eval_string)
          end

          #puts @rule_actions.map { |i| i.obje }
          #att=ActionToTake.new
          #@process_stage=att.create_process_stage()
          #@rule_actions.all do |ra|
          #  if !ra.argu.nil?
          #  puts instance_eval("#{ra.obje}"+"."+"#{ra.fncnt}(#{ra.argu})")
          #  else
          #  puts instance_eval("#{ra.obje}"+"."+"#{ra.fncnt}")
          #  end
          #end
          #instance_eval(@process_stage.stage="next_stage")
          #instance_eval(@process_stage.save)
          #file_path =  "#{Rails.root}/public/ManpowerPlan2013.xlsx"

          #instance_eval("Position.create_using_doc('#{Rails.root}/public/ManpowerPlan2013.xlsx')")
          #at = ActionToTake.new
          ##at.notify({:job_role => 'Admin'})
          #msg = at.get_last_message
          ##msg_body = at.get_msg_body(msg.message_id)
          #puts msg.message_id
          #msg.body.each do |msg_body|
          #  if (msg_body["body_section"].to_i % 2 != 0)
          #    puts msg_body["content"]
          #  end
          #end

          #load_custom_rules
        }
      }
    end

  end

end

class ActionToTake
  def notify(args={})
    if !args[0].nil?
      puts "Notification sent to all " + args[0]
      #Notification.send_notification({:candidates_email => "nikunj.0407@gmail.com", :message => "Hello Nikunj !!!"})
    else
      puts "Notification send to all of them"
    end
  end

  def create(args={})
    puts "Creating " + args[0]
    eval_string = args[0] + ".create_using_doc([{'doc_id' => '" + args[2] + "'}])"
    puts eval_string
    instance_eval(eval_string)
  end

  def approved(args={})
    puts 'Creating process stage ...' + args[:initiated_by]
    current_process = create_process_stage({:name => args[:name], :initiated_by => args[:initiated_by]})
    puts 'Process stage created ...'
    instance_eval("notify({:job_role=>'HR'})")
  end

  def create_process_stage(args={})
    @@current_process = ProcessStage.create!(:name => args[:name], :initiated_by => args[:initiated_by], :current_stage => ProcessMaster.where(:name => args[:name]).first.stages.first.name, :current_operation => ProcessMaster.where(:name => args[:name]).first.stages.first.operations.first.name, :chits => [Chit.new(:oclass => "Document", :refid => Document.last.id)])
    return @@current_process
  end

  def create_chits(args={})
    @@current_process=args[:current_stage]
  end

  def remove_chits

  end

  def call_events

  end

  def get_last_message
    message = $cio_account.messages.where(subject: 'Candidate', include_body: 1).first
    return message
  end

  def get_msg_body(msg_id)
    msg_body = $cio_account.messages[msg_id]
    return msg_body
  end
end



require 'wongi-engine'

class RuleBook
  # To change this template use File | Settings | File Templates.
  #$rule_name="#{CustomRule.first.predicate}"
  $subject=eval(":"+"Uploaded_by")
  $object=eval(":"+"Doc_file_name")
  $vvv="1"
  $predicate="changed"
  $condition = ""

  def document_rules

    ruleset do
      name "doc_rules"
      #rule "initialise" do
      #  forall {
      #    has :Uploaded_by, "uploads", :Doc_file_name
      #    assert :Doc_file_name do |doc|
      #      doc.include? "MPPD"
      #    end
      #  }
      #  make {
      #    action { |token|
      #      #Todo:Send this document to Bussiness head for Approval.
      #      puts "Rule engine activated...."
      #      actions = RuleActions.new
      #      current_process = actions.initialize_current_process({:name => "Recruitment", :initiated_by => "#{:Uploaded_by}"})
      #    }
      #  }
      #end

      rule "approved" do
        forall {
          has :Approved_by, "approved", :Doc_file_name
          any {
            option{
              assert :Doc_file_name do |doc|
                doc.include? "MPPD"
              end
            }
            option{
              assert :Approved_by do |doc|
                doc.include? "MPPD"
              end
            }

          }
        }
        make {
          action { |token|
            #Todo:Send this document to Bussiness head for Approval.
            puts "MPPD Approved"
            puts "Creating Vacancies"
            #actions=RuleActions.new
            #cp=actions.look
          }
        }
      end



    end

    def contains_string(doc, sub)
      doc.include? sub
    end

  end

  #def new_rule(args={})
  #  puts "Inside new rule"
  #  $rule_engine << [args[subject], args[predicate], args[object]]
  #  $condition = eval(args[condition])
  #  #$rule_engine << [self.uploaded_by, "changed", self.doc_file_name]
  #end

end

class RuleActions
  def initialize_current_process(args={})
    puts "This is action of rule............"
    puts args[:name]
    @@current_process = ProcessStage.create!(:name => args[:name], :current_stage => ProcessMaster.where(:name => args[:name]).first.stages.first.name, :current_operation => ProcessMaster.where(:name => args[:name]).first.stages.first.operations.first.name, :chits => [Chit.new(:oclass => "Document", :refid => Document.last.id)])
    puts @@current_process.id
    puts @@current_process.chits.first.id
    puts @@current_process.chits.first.document_state
    @@current_process.chits.first.send_for_approval_docu
    puts @@current_process.chits.first.document_state
    puts @@current_process.chits.first.approved_by_everyone_docu
    puts @@current_process.chits.first.document_state
    doc=eval(@@current_process.chits.first.oclass).find("#{@@current_process.chits.first.refid}")
    puts "#{doc.uploaded_by}, approved ,#{doc.doc_file_name}"
    $rule_engine << [doc.uploaded_by, "approved", doc.doc_file_name]
    $rule_engine << [doc.uploaded_by, "changed", doc.doc_file_name]
  end

  def look
    puts "Inside Look....."
    puts @@current_process.chits.first.document_state
    vac= @@current_process.chits.create!(:oclass => "Position", :refid => Position.all.sample.id)

  end

  def perform_operation(operation_name)
    case operation_name
      when "11"
        puts "Create vacancy here"
      when "12"
        puts "Operation 12"
      when "13"
        puts "Operation 13"
      when "22"
        puts "Operation 22"
      else
        puts "You gave me #{operation_name} -- I have no idea what to do with that."
    end
  end


end

class DynamicRuleBook

  def dynamic_rules

  end

end
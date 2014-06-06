class EmployeeMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :employee_code, type: String
  field :employee_name, type: String
  field :employee_middle_name_name, type: String
  field :status, type: String
  field :gender, type: String
  field :marital_status, type: String
  field :date_of_birth, type: Date
  field :date_of_joining, type: Date
  field :role_ids, type: Array
  field :parent_ids, type: Array
  field :group_master_ids, type: Array
  field :vendor_id, type: String
  field :designation_joined_at, type: String
  field :official_email, type: String
  field :address_for_communication, type: String
  field :approved, type: Boolean
  field :deleted, type: Boolean

  belongs_to :user
  #belongs_to :group_master
  has_and_belongs_to_many :group_masters

  # field :group_master_id, type: String

  # embeds_many :reporting_tos

  has_one :employee_detail

  has_and_belongs_to_many :roles

  #accepts_nested_attributes_for :roles

  # accepts_nested_attributes_for :reporting_tos

  #accepts_nested_attributes_for :group_masters

  has_and_belongs_to_many :reps, :inverse_of => :parents,  :class_name => 'EmployeeMaster', :autosave => true
  has_and_belongs_to_many :parents,  :inverse_of => :reps, :class_name => 'EmployeeMaster', :autosave => true
  accepts_nested_attributes_for :reps
  accepts_nested_attributes_for :group_masters
  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :parents

  after_create :create_user

  # has_many :assessments

  rails_admin do
    navigation_label "Emp Masters"
  end

  #TODO: uncomment validations
  #validates :official_email,
  #          :presence => true,
  #          :uniqueness => true,
  #          :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  #
  #validates :employee_code, :presence => true
  #
  #validates :employee_name,
  #          :presence   => true,
  #          :format     => { :with => /^[A-Za-z.&]*\z/ } #validation for no-special characters
  #
  #validates :employee_middle_name_name,
  #          :format     => { :with => /^[A-Za-z.&]*\z/ }
  #
  #validates :status,
  #          :presence => true,
  #          :format     => { :with => /^[A-Za-z.&]*\z/ }
  #
  #
  #validates :gender,
  #          :presence => true
  #
  #def self.genders
  #  %w(M F O)
  #end
  #
  #validates_inclusion_of :gender, :in => EmployeeMaster.genders
  #
  #validates :marital_status, :presence => true
  #validates :date_of_birth, :presence => true
  #validates :date_of_joining, :presence => true
  #
  #validates_date :date_of_joining, :on_or_before => lambda { Date.current }
  #
  #validates :designation_joined_at, :presence => true
  ##validates :reporting_tos, :presence => true
  #
  #validates :address_for_communication, :presence => true



  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      # puts "--------------------------------------------------------------------------------------------"
      #
      # puts "#{spreadsheet.row(i)[11].to_s}"#.split(',').map{|j| GroupMaster.where(:group_name => j).first.id}
      # puts "--------------------------------------------------------------------------------------------"
      @employee_master = EmployeeMaster.create!(employee_code:spreadsheet.row(i)[0].to_s,
                                                employee_name:spreadsheet.row(i)[1].to_s,
                                                employee_middle_name_name:spreadsheet.row(i)[2].to_s,
                                                status:spreadsheet.row(i)[3].to_s,
                                                gender:if spreadsheet.row(i)[4].to_s == "Male" then "M" elsif spreadsheet.row(i)[35].to_s == "Female" then "F" else "O" end,
                                                marital_status:spreadsheet.row(i)[5].to_s,
                                                date_of_birth:if spreadsheet.row(i)[6].blank? then "" else spreadsheet.row(i)[6].to_date end,
                                                date_of_joining:if spreadsheet.row(i)[7].blank? then "" else spreadsheet.row(i)[7].to_date end,
                                                designation_joined_at:spreadsheet.row(i)[8].to_s,
                                                official_email:spreadsheet.row(i)[9].to_s,
                                                address_for_communication:spreadsheet.row(i)[10].to_s,
                                                parent_ids:if spreadsheet.row(i)[11].blank? then [] else [if !EmployeeMaster.where(:employee_code => spreadsheet.row(i)[11].to_s).first.nil? then EmployeeMaster.where(:employee_code => spreadsheet.row(i)[11].to_s).first.id end] end,
                                                role_ids:[(Role.where(:name => spreadsheet.row(i)[12].to_s).first.id rescue '')],
                                                group_master_ids:spreadsheet.row(i)[13].to_s.split(',').map{|i| GroupMaster.where(:group_name => i).first.id})
                                                # parent_ids:
      #employee_detail = EmployeeDetail.create!(current_designation:spreadsheet.row(i)[9].to_s, job_role_id:spreadsheet.row(i)[9].to_s, band_id:, total_work_exp_years:, total_work_exp_months:, personal_email:, contact_numbers:, personal_address:, bank_name:, account_number:, rf_no:, esic_no:, pan_no:, blood_group:, date_of_leaving, type: Date:, nature_of_separation:, remarks_1:, remarks_2:, remarks_3:, remarks_4:, remarks_5)
      # @employee_detail = EmployeeDetail.create!(current_designation:spreadsheet.row(i)[9].to_s, job_role_id: "", band_id:spreadsheet.row(i)[11].to_s, total_work_exp_years:spreadsheet.row(i)[18].to_s, personal_email:spreadsheet.row(i)[22].to_s, contact_numbers:spreadsheet.row(i)[23].to_s, bank_name:spreadsheet.row(i)[26].to_s, account_number:spreadsheet.row(i)[27].to_s, esic_no:spreadsheet.row(i)[29].to_s, pan_no:spreadsheet.row(i)[30].to_s, blood_group:spreadsheet.row(i)[34].to_s, date_of_leaving:spreadsheet.row(i)[36].to_s, nature_of_separation:spreadsheet.row(i)[37].to_s)
      #puts "@employee_detail : " + @employee_detail.job_role_id

      #@employee_detail.employment_hists.build!()
      #@employee_detail.educations.build!()
      #@employee_detail.family_details.build!()
      #@employee_detail.pf_nominations.build!()
      #@employee_detail.esis_nominations.build!()
      # @employee_detail.save

      # @employee_master.employee_detail=@employee_detail
      # @employee_master.save
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then
        Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then
        Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then
        Roo::Excelx.new(file.path, nil, :ignore)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end

  def create_user
    self.user=User.create!(:email =>self.official_email, :password =>"password", :password_confirmation =>"password")
    self.save
  end

  def final_rating(goal_id)
    @p = PmsAssessment.where(:employee_id => self.id, :goal_id => goal_id)
    @final_rating = 0
    @p.each do |p|
      @final_rating = @final_rating + (p.cr rescue 0)
    end
    return @final_rating.round
  end

end

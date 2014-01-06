class EmployeeMaster
  include Mongoid::Document
  include Mongoid::Paperclip

  #field :user_id, type: Integer
  field :employee_code, type: String
  field :employee_name, type: String
  field :employee_middle_name_name, type: String
  field :status, type: String
  field :gender, type: String
  field :marital_status, type: String
  field :date_of_birth, type: Date
  field :date_of_joining, type: Date
  field :group_id, type: Integer
  field :designation_joined_at, type: String
  field :current_designation, type: String
  field :job_id, type: Integer
  field :band_id, type: Integer
  field :total_work_exp_years, type: Integer
  field :total_work_exp_months, type: Integer
  field :official_email, type: String
  field :personal_email, type: String
  field :contact_numbers, type: String
  field :personal_address, type: String
  field :address_for_communication, type: String
  field :bank_name, type: String
  field :account_number, type: String
  field :rf_no, type: String
  field :esic_no, type: String
  field :pan_no, type: String
  field :blood_group, type: String
  field :date_of_leaving, type: Date
  field :nature_of_separation, type: String
  field :remarks_1, type: String
  field :remarks_2, type: String
  field :remarks_3, type: String
  field :remarks_4, type: String
  field :remarks_5, type: String
  has_mongoid_attached_file :employee_cv

  belongs_to :user

  embeds_many :reporting_tos
  embeds_many :employment_hists
  embeds_many :educations
  embeds_many :family_details
  embeds_many :pf_nominations
  embeds_many :esis_nominations


  accepts_nested_attributes_for :reporting_tos
  accepts_nested_attributes_for :employment_hists
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :family_details
  accepts_nested_attributes_for :pf_nominations
  accepts_nested_attributes_for :esis_nominations

  #uncomment these starts
  validates :employee_code, :presence => true

  validates :employee_name,
            :presence   => true,
            :format     => { :with => /^[A-Za-z.&]*\z/ } #validation for no-special characters

  validates :employee_middle_name_name,
            :format     => { :with => /^[A-Za-z.&]*\z/ }

  validates :status,
            :presence => true,
            :format     => { :with => /^[A-Za-z.&]*\z/ }


  validates :gender,
            :presence => true

  def self.genders
    %w(M F O)
  end

  validates_inclusion_of :gender, :in => EmployeeMaster.genders
  #uncomment these ends

  validates :marital_status, :presence => true
  validates :date_of_birth, :presence => true

  validates :date_of_joining, :presence => true

  #def not_long_ago?( date_of_joining )
  #  date_of_joining >= 1.day.ago
  #end


  #validates :group_id, :presence => true
  #validates :designation_joined_at, :presence => true
  #validates :current_designation, :presence => true
  #validates :job_id, :presence => true
  #validates :band_id, :presence => true
  #validates :reporting_tos, :presence => true
  #validates :total_work_exp_years, :presence => true
  #validates :total_work_exp_months, :presence => true
  #validates :employment_hists, :presence => true
  #validates :official_email, :presence => true
  #validates :personal_email, :presence => true
  #validates :contact_numbers, :presence => true
  #validates :personal_address, :presence => true
  #validates :address_for_communication, :presence => true
  #
  #validates :bank_name, :presence => true
  #validates :account_number, :presence => true
  #validates :pf_nominations, :presence => true
  #validates :rf_no, :presence => true
  #validates :esic_no, :presence => true
  #validates :pan_no, :presence => true
  #validates :esis_nominations, :presence => true
  #validates :blood_group, :presence => true


end

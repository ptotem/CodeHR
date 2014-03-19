class EmployeeDetail
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip


  field :current_designation, type: String
  field :job_role_id, type: String
  field :band_id, type: Integer
  field :total_work_exp_years, type: Integer
  field :total_work_exp_months, type: Integer
  field :personal_email, type: String
  field :contact_numbers, type: String
  field :personal_address, type: String
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
  field :deleted, type: Boolean

  belongs_to :employee_master

  embeds_many :employment_hists
  embeds_many :educations
  embeds_many :family_details
  embeds_many :pf_nominations
  embeds_many :esis_nominations

  accepts_nested_attributes_for :employment_hists
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :family_details
  accepts_nested_attributes_for :pf_nominations
  accepts_nested_attributes_for :esis_nominations

  #TODO: uncomment validations
  #validates :personal_email,
  #          :presence => true,
  #          :uniqueness => true,
  #          :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  #
  #
  #validates :current_designation, :presence => true
  #validates :job_role_id, :presence => true
  #validates :band_id, :presence => true
  #
  #validates :total_work_exp_years,
  #          :presence => true,
  #          numericality: { only_integer: true, greater_than: 0 }
  #
  #validates :total_work_exp_months,
  #          :presence => true,
  #          numericality: { only_integer: true }
  #
  #validates :contact_numbers,
  #          :presence => true,
  #          length: { is: 10 },
  #          numericality: { only_integer: true }
  #
  #validates :bank_name, :presence => true
  #validates :account_number, :presence => true
  #validates :rf_no, :presence => true
  #validates :esic_no, :presence => true
  #validates :pan_no, :presence => true
  #
  #validates :blood_group, :presence => true
  #
  ##embeds_many associations validations starts
  #validates :employment_hists, :presence => true
  #validates :pf_nominations, :presence => true
  #validates :esis_nominations, :presence => true
  ##embeds_many associations validations ends

end

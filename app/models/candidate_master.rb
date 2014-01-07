class CandidateMaster
  include Mongoid::Document
  include Mongoid::Paperclip

  field :candidate_code, type: String
  field :candidate_name, type: String
  field :candidate_middle_name, type: String
  field :status, type: String
  field :gender, type: String
  field :marital_status, type: String
  field :date_of_birth, type: Date
  field :total_work_exp_years, type: Integer
  field :total_work_exp_months, type: Integer
  field :official_email, type: String
  field :personal_email, type: String
  field :bank_name, type: String
  field :account_number, type: String
  field :pf_no, type: String
  field :esic_no, type: String
  field :pan_no, type: String
  field :current_location, type: String
  field :salary_expectation_fixed, type: Float
  field :salary_expectation_variable, type: Float
  field :notice_period, type: String
  field :notice_period_buyback?, type: Boolean
  field :notice_period_buyback_amount, type: Float
  field :remarks_1, type: String
  field :remarks_2, type: String
  field :remarks_3, type: String
  field :remarks_4, type: String
  field :remarks_5, type: String

  has_mongoid_attached_file :employee_cv

  embeds_many :cand_educations
  embeds_many :candidate_contact_numbers
  embeds_many :candidate_employment_histories
  embeds_many :communication_addresses
  embeds_many :candidate_family_details
  embeds_many :job_preferences
  embeds_many :location_preferences
  has_many :vacancy_schedulings

  accepts_nested_attributes_for :cand_educations
  accepts_nested_attributes_for :candidate_contact_numbers
  accepts_nested_attributes_for :candidate_employment_histories
  accepts_nested_attributes_for :communication_addresses
  accepts_nested_attributes_for :candidate_family_details
  accepts_nested_attributes_for :job_preferences
  accepts_nested_attributes_for :location_preferences
  accepts_nested_attributes_for :vacancy_schedulings

  validates :candidate_code, :presence => true

  validates :candidate_name,
            :presence   => true,
            :format     => { :with => /^[A-Za-z.&]*\z/ } #validation for no-special characters

  validates :official_email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  validates :personal_email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  validates :status,
            :presence => true,
            :format     => { :with => /^[A-Za-z.&]*\z/ }


  validates :gender,
            :presence => true

  def self.genders
    %w(M F O)
  end

  validates_inclusion_of :gender, :in => CandidateMaster.genders

  validates :marital_status, :presence => true
  validates :date_of_birth, :presence => true

  validates :total_work_exp_years,
            :presence => true,
            numericality: { only_integer: true, greater_than: 0 }

  validates :total_work_exp_months,
            :presence => true,
            numericality: { only_integer: true }

  validates :personal_email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  #TODO: check this
  #validates :candidate_contact_numbers,
  #          :presence => true,
  #          length: { is: 10 },
  #          numericality: { only_integer: true }

  validates :communication_addresses,
            :presence => true

  validates :current_location, :presence => true
  validates :salary_expectation_fixed, :presence => true
  validates :salary_expectation_variable, :presence => true

  validates :notice_period, :presence => true
  #validates :notice_period_buyback?, :presence => true


end

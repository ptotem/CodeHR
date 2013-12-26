class CandidateMaster
  include Mongoid::Document
  include Mongoid::Paperclip
<<<<<<< HEAD
=======

>>>>>>> 080ed5d36341346651b140262c8770280393679b
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
end

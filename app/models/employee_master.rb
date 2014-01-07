class EmployeeMaster
  include Mongoid::Document
  include Mongoid::Paperclip

  field :employee_code, type: String
  field :employee_name, type: String
  field :employee_middle_name_name, type: String
  field :status, type: String
  field :gender, type: String
  field :marital_status, type: String
  field :date_of_birth, type: Date
  field :date_of_joining, type: Date

  field :designation_joined_at, type: String
  field :official_email, type: String
  field :address_for_communication, type: String

  belongs_to :user
  belongs_to :group_master

  field :group_master_id, type: String

  embeds_many :reporting_tos

  has_one :employee_detail

  accepts_nested_attributes_for :reporting_tos

  validates :official_email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

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

  validates :marital_status, :presence => true
  validates :date_of_birth, :presence => true
  validates :date_of_joining, :presence => true

  validates_date :date_of_joining, :on_or_before => lambda { Date.current }

  validates :designation_joined_at, :presence => true
  #validates :reporting_tos, :presence => true

  validates :address_for_communication, :presence => true

end

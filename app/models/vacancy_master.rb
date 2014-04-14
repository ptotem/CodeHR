class VacancyMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :vacancy_code, type: String
  field :manpower_planning_id, type: Integer
  field :vendor_master_id, type: String
  field :description, type: String
  field :status, type: String
  field :sourcing_strategy, type: String
  field :refer_doc_id, type: String
  field :hr_rep, type: String
  field :hiring_manager, type: String
  field :ctc_range_from, type: Integer
  field :ctc_range_to, type: Integer
  field :deleted, type: Boolean

  belongs_to :group_master
  belongs_to :job_description_master
  belongs_to :manpower_planning
  has_many :vacancy_schedulings
  accepts_nested_attributes_for :vacancy_schedulings

  before_create :check_and_create_code
  #validates :vacancy_code, :presence => true
  #validates :description, :presence => true

  #validates :status, :presence => true

  #validates :sourcing_strategy, :presence => true
  #validates :hr_rep, :presence => true
  #validates :ctc_range_from, :presence => true
  #validates :ctc_range_to, :presence => true

  def check_and_create_code
    if self.vacancy_code.nil?
      num = VacancyMaster.all.length rescue 1
      self.vacancy_code = @dynamic_code = I18n.translate('config.AutoCode.VacancyMaster.text')+sprintf('%0'+I18n.translate('config.AutoCode.VacancyMaster.digit')+'d',(num+1))
    end
  end

end

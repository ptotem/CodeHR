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
  field :no_of_position, type: Integer, default: 1 
  field :occupied_position, type: Integer, default: 0 
  field :manpower_id, type: String
  field :band_master, type: Hash
  field :ff_source, type: String
  field :role, type: Hash
  field :candidates, type: Hash, default: {}
  field :erased, type: Boolean

  belongs_to :group_master
  belongs_to :job_description_master
  belongs_to :manpower_planning
  has_many :vacancy_schedulings
  has_many :candidate_master
  accepts_nested_attributes_for :vacancy_schedulings

  before_create :check_and_create_code

  after_save :change_vacancy_count
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

  def change_vacancy_count
    count = 0;
    self.candidates.each do |uid, obj|
      if obj['status'] == 'Accepted'
        count = count + 1
      end
    end
    self.occupied_position = count
  end

end

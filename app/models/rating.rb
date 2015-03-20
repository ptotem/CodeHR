class Rating
  include Mongoid::Document
  include Mongoid::Timestamps
  field :comments, type: String
  field :candidate_master_id, type: String
  field :erased, type: Boolean
  embeds_many :score_receiveds
  has_many :dynamic_fields
  accepts_nested_attributes_for :score_receiveds

  belongs_to :vacancy_scheduling

  validates :comments, :presence => true

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      @rating = Rating.create!(comments:spreadsheet.row(i)[0].to_s, candidate_master_id: CandidateMaster.where(candidate_name: spreadsheet.row(i)[0].to_s).first)
      #@score_received = ScoreReceived.create!(rating_scale_id:spreadsheet.row(i)[2].to_s, sr_name: spreadsheet.row(i)[2].to_s)
      #@score_received.save
      #@rating.score_receiveds=@score_received
      @rating.save
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

end

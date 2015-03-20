class BandMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :band_code, type: String
  field :band_name, type: String
  field :erased, type: Boolean

  belongs_to :company_master

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      @band_master = BandMaster.create!(band_code:spreadsheet.row(i)[0].to_s, band_name:spreadsheet.row(i)[1].to_s)
      @band_master.save
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

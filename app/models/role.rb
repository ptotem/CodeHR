class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :created_by_process, type: Boolean
  field :process_id, type: String
  field :erased, type: Boolean
  #field :employee_master_ids, type: Array
  has_and_belongs_to_many :employee_masters
  # belongs_to :employee_master
  # has_many :employee_masters
  # has_many :job_description_masters
  accepts_nested_attributes_for :employee_masters

  belongs_to :user

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      @role = Role.create!(name:spreadsheet.row(i)[0].to_s)
      @role.save
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

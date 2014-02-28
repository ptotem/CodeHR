class GroupMaster
  include Mongoid::Document
  field :group_code, type: String
  field :group_name, type: String
  field :created_by_process, type: Boolean
  field :process_id, type: String
  field :company_master_id, type: String
  field :child_group_master_ids, type: Array
  field :deleted, type: Boolean
  recursively_embeds_many
  belongs_to :company_master
  has_many :manpower_plannings
  has_many :vacancy_masters
  has_many :employee_masters

  has_many :child_groups, :class_name => 'GroupMaster', :inverse_of => :parent_group
  belongs_to :parent_group, :class_name => 'GroupMaster', :inverse_of => :child_group

  #accepts_nested_attributes_for :parent_group
  accepts_nested_attributes_for :manpower_plannings
  accepts_nested_attributes_for :vacancy_masters
  accepts_nested_attributes_for :employee_masters

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      @group_master = GroupMaster.create!(group_code:spreadsheet.row(i)[0].to_s, group_name:spreadsheet.row(i)[1].to_s)
      @group_master.save
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

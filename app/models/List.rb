class List
  include ActiveModel::Model

  attr_accessor :address, :name, :description, :access_level, :created_at, :members_count

  ACCESS_LEVELS = ["readonly", "members", "everyone"]

  validates :address, presence: true
  validates :access_level, inclusion: { in: ACCESS_LEVELS, messages: "unknown access level type" }
  validates_format_of :email, :with => /@/
  validates :members_count, :numericality => { :greater_than_or_equal_to => 0 }

  def self.all
    json = Mailgun().lists.list
    @lists = parse_json(json)
  end

  def self.add address, params
    Mailgun().lists.create address, params
  end

  def self.find_by_address address
    json = Mailgun().lists.find(address)["list"]
    List.new(json)
  end


  private

  def self.parse_json json
    a = Array.new
    json.each do |list|
      a << List.new(list)
    end
    a
  end
end

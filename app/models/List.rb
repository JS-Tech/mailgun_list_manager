class List
  include ActiveModel::Model

  ACCESS_LEVELS = ["readonly", "members", "everyone"]

  attr_accessor :address,
                :name,
                :description,
                :access_level,
                :created_at,
                :members_count

  validates :address, presence: true
  validates :access_level, inclusion: { in: ACCESS_LEVELS, messages: "unknown access level type" }
  validates_format_of :address, :with => /@/
  validates :members_count, :numericality => { :greater_than_or_equal_to => 0 }

  # CRUD operations

  def update(list_params)
    json = Mailgun().lists.update(address, list_params["address"], list_params)
    List.new(json["list"])
  end

  def delete
    Mailgun().lists.delete address
  end

  # Relational stub

  def members
    json = Mailgun().list_members(address).list
    Member.parse_json(json, self)
  end

  # Statics

  def self.all
    json = Mailgun().lists.list
    @lists = parse_json(json)
  end

  def self.add(address, params)
    Mailgun().lists.create(address, params)
  end

  def self.find_by_address(address)
    json = Mailgun().lists.find(address)["list"]
    List.new(json)
  end

  private

  def self.parse_json(json)
    a = Array.new
    json.each do |list|
      a << List.new(list)
    end
    a
  end
end

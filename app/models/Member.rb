class Member
  include ActiveModel::Model

  attr_accessor :vars,
                :name,
                :subscribed,
                :address,
                :list

  validates :subscribed, inclusion: { in: [true, false], messages: "must be true or false" }

  def initialize(attributes = {}, list)
    super(attributes)
    @list = list
  end

  # CRUD operations

  def delete
    Mailgun().list_members(list.address).remove(address)
  end

  # Class operations

  def self.add(list_address, address)
    Mailgun().list_members(list_address).add(address)
  end

  def self.delete_by_addresses(list_address, address)
    Mailgun().list_members(list_address).remove(address)
  end

  def self.parse_json(json, list)
    p json
    a = Array.new
    json.each do |member|
      a << Member.new(member, list)
    end
    a
  end

end

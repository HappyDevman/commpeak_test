require 'csv'

class CsvImporter
  attr_accessor :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  class << self
    def call(*args)
      new(*args).call
    end
  end

  def call
    file = "#{Rails.root}/public/tickets.csv"
    return false unless File.exist?(file)

    csv_text = File.read(file)
    csv = CSV.parse(csv_text, headers: true)
    length = 0
    csv.each do |row|
      current_user.tickets.create!(row.to_hash)
      length += 1
    rescue StandardError
      next
    end
    length
  end
end

require 'csv'

class CsvExporter
  attr_accessor :ticket

  def initialize(ticket)
    @ticket = ticket
  end

  class << self
    def call(*args)
      new(*args).call
    end
  end

  def call
    file = "#{Rails.root}/public/tickets.csv"
    headers = %w[name email subject content]
    file_existing = File.exist?(file)
    CSV.open(file, 'a+', write_headers: !file_existing, headers: headers) do |csv|
      csv << [ticket[:name], ticket[:email], ticket[:subject], ticket[:content]]
    end
  end
end

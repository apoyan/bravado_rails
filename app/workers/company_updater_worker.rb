require 'zip'
require 'csv'
require 'ruby-progressbar'
require 'net/http'
require 'uri'

class CompanyUpdaterWorker
  include Sidekiq::Worker
  SNAPSHOTS_BASE_URL = 'http://download.companieshouse.gov.uk/BasicCompanyData-' #2018-08-01-part1_5.zip
  DATE_FORMAT = '%Y-%m-%d'

  def perform(part)
    url = "#{SNAPSHOTS_BASE_URL}#{Date.today.beginning_of_month.strftime(DATE_FORMAT)}-part#{part}_5.zip"
    uri = URI.parse(url)

    response = download_with_progressbar(uri, part)
    if response.code.to_i == 200
      parse_data(part)
    else
      Rails.logger.info "PART #{part}: #{response.code} #{response.msg}"
    end
  end

  # private

  def download_with_progressbar(uri, part)
    response = nil

    Net::HTTP.start(uri.host) do |http|
      response = http.request_head(URI.escape(uri.path))
      pbar = ProgressBar.create(title: 'PART 1', total: response['content-length'].to_i)

      File.open("part_#{part}.zip", 'wb') do |f|
        response = http.get(URI.escape(uri.path)) do |str|
          f.write str
          pbar.progress += str.length
        end
      end

      pbar.finish
    end

    response
  end

  def parse_data(part)
    file = File.open("part_#{part}.zip")
    Zip::File.open_buffer(file) do |zip|
      zip.glob('*.csv').each do |entry|
        return unless entry.file?

        content = entry.get_input_stream.read.force_encoding('utf-8')
        csv = CSV.parse(content, headers: true)
        csv.each do |row|
          puts row[1]
          Company.find_or_create_by(number: row[1]) do |company|
            company.name = row[0]
          end
        end
      end
    end
  end
end

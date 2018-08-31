require 'open-uri'
require 'zip'
require 'csv'

class Company < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, :number, presence: true
  validates :number, uniqueness: true

  SNAPSHOTS_PARTS_COUNT = 5

  def self.update_from_snapshot
    1.upto(SNAPSHOTS_PARTS_COUNT) do |part|
      CompanyUpdaterWorker.perform_async(part)
    end
  end
end

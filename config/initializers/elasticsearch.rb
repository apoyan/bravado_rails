config = YAML.load_file(File.join(Rails.root, %w[config elasticsearch.yml]))
host = config[Rails.env][:host] rescue nil

Elasticsearch::Model.client = Elasticsearch::Client.new(host: host, log: true)
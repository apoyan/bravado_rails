config = YAML.load_file(File.join(Rails.root, %w[config sidekiq.yml]))
connection_string = config[Rails.env][:connection] rescue nil

Sidekiq::Logging.logger = nil if Rails.env.test?

Sidekiq.configure_server do |cnf|
  Rails.logger = Sidekiq::Logging.logger
  cnf.redis = { url: connection_string }
end

Sidekiq.configure_client do |cnf|
  cnf.redis = { url: connection_string }
end

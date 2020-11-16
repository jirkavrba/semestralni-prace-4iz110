# frozen_string_literal: true

# Configure the elasticsearch connection
Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV.fetch('ELASTICSEARCH_URL', 'localhost:9200')

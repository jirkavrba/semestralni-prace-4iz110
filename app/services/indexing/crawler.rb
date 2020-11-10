require 'uri'

module Indexing
  class Crawler
    def initialize(domain, max_depth = 3)
      @root = domain
      @root_host = URI.parse(domain).host
      @max_depth = max_depth
    end

    def run(&block)
      @urls_indexed = {}
      @callback = block

      index @root
    end

    def index(url, depth = 0)
      url = normalize_url url
      invalid = (depth == @max_depth) || another_domain?(url) || already_indexed?(url)

      # Process the given url, this also adds it to the index
      process url, depth unless invalid

    rescue StandardError
      # TODO: Log errors
      # Ignored
    end

    private

    def process(url, depth)
      @urls_indexed[url] = true

      page = agent.get(url)

      # Do the actual indexing / analytics
      @callback.call(page)

      # Process all the links
      page.links.each do |link|
        index link.href, depth + 1
      end
    end

    def agent
      @agent ||= Mechanize.new
    end

    def normalize_url(url)
      url = agent.resolve(url).to_s
      url.split('#').first # Ignore the hash (as it's the same page)
    end

    def already_indexed?(url)
      @urls_indexed.key?(url)
    end

    def another_domain?(url)
      URI.parse(url).host != @root_host
    end
  end
end
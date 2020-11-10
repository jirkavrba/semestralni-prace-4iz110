require 'uri'

module Indexing
  class Crawler
    # The maximum number of links followed from the root node
    MAX_LINK_DEPTH = 3

    def initialize(domain)
      @root = domain
      @root_host = URI.parse(domain).host
      @urls_indexed = {}
    end

    def run
      index @root
    end

    def index(url, links_depth = 3)
      # Normalizes the url to prevent duplication
      url = agent.resolve(url).to_s
      # Ignore the hash (as it's the same page)
      url = url.split('#').first

      return if links_depth.zero? || another_domain?(url) || already_indexed?(url)

      p "Indexing #{url} (depth from root node: #{links_depth})"

      @urls_indexed[url] = true

      links = agent.get(url)&.links || []
      links.each { |link| index link.href, links_depth - 1 }
    rescue StandardError
      # TODO: Log errors
      # Ignored
    end

    private

    def agent
      @agent ||= Mechanize.new
    end

    def already_indexed?(url)
      @urls_indexed.key?(url)
    end

    def another_domain?(url)
      URI.parse(url).host != @root_host
    end
  end
end
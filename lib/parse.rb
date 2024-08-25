require "httparty"
require "nokogiri"

class Parse
  include HTTParty

  def initialize(url)
    # @doc = File.open("./example/example.html") { |f| Nokogiri::HTML5(f) }
    @doc = Nokogiri::HTML5(HTTParty.get(url))
  end

  def image_urls
    doc.css("div.page-break").map do |page|
      page.at_css('img')['src'].strip
    end
  end

  private

  attr_reader :doc
end

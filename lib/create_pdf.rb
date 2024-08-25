# frozen_string_literal: true
require "prawn"
require "tempfile"
require "httparty"
require_relative "parse"

class CreatePdf
  include HTTParty

  def initialize(url_to_chapter, filename)
    @url_to_chapter = url_to_chapter
    @filename = filename
  end

  def create
    images = image_urls.map do |image_url|
      parsed_response = HTTParty.get(image_url).parsed_response

      temp_image_file = Tempfile.new(url_to_chapter.split("/").last.split("."))
      temp_image_file.write(parsed_response)
      temp_image_file.rewind
      temp_image_file
    end

    Prawn::Document.generate(filename) do
      images.each do
        image _1, scale: 0.65, position: :center, vposition: :center
      end
    end

    images.each do
      _1.close
      _1.unlink
    end
  end

  private

  attr_reader :url_to_chapter, :filename

  def image_urls
    Parse.new(url_to_chapter).image_urls
  end
end

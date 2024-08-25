# frozen_string_literal: true

require_relative "lib/parse"
require_relative "lib/create_pdf"

URL_WITHOUT_CHAPTER_NUMBER = "https://www.vinlandsagamanga.net/manga/vinland-saga-chapter-"

print "Send number of chapeter: "
number = gets.chomp
url = "#{URL_WITHOUT_CHAPTER_NUMBER}-#{number}/"
CreatePdf.new(url, filename:"vinland-saga-chapter-#{number}.pdf").create

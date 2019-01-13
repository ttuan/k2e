require "kindleclippings"
require "dotenv/load"
require "./lib/date_checker"
require "./lib/evernote"
require "./lib/kindle"

class K2e
  include DateChecker

  attr_reader :kindle

  def initialize
    @kindle = Kindle.new
  end

  def perform
    kindle.books_highlights.each do |book_title, highlights_content|
      note = Evernote::Note.new(
        title: book_title,
        content: highlights_content,
        notebook_name: ENV["NOTEBOOK"]
      )

      note.update
    end
  end
end

K2e.new.perform

$LOAD_PATH << File.dirname(__FILE__)

require "kindleclippings"
require "dotenv/load"
require "./lib/date_checker.rb"
require "./lib/evernote.rb"
require "./lib/kindle.rb"

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

    update_last_sync_date
  end
end

K2e.new.perform

require "k2e/date_supporter.rb"
require "k2e/evernote.rb"
require "k2e/kindle.rb"

require "k2e/version"

module K2e
  extend K2e::DateSupporter

  def self.sync
    kindle = Kindle.new

    kindle.books_highlights.each do |book_title, highlights_content|
      note = K2e::Note.new(
        title: book_title,
        content: highlights_content,
        notebook_name: ENV["NOTEBOOK"]
      )

      note.update
    end

    update_last_sync_date
  end
end

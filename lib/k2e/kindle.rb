require "kindleclippings"
require "time"

module K2e
  class Kindle
    include ::K2e::DateSupporter

    attr_reader :parser

    def initialize
      @parser = KindleClippings::Parser.new
    end

    def books_highlights
      clippings = parser.parse_file(clippings_file_path)

      @result = {}

      highlights = clippings.highlights.delete_if{|highlight| highlight.added_on < last_sync_date}
      highlights.group_by(&:book_title).each do |book_title, book_highlights|
        next if book_highlights.empty?
        note_content = ""

        book_highlights.each do |highlight|
          str_date = Time.parse highlight.added_on.to_s
          note_content += <<-CONTENT
            <div>A highlight is created on #{str_date}, starting at location #{highlight.location} </div>

            <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
              <div>
                <i style="background-color:rgb(255, 250, 165);-evernote-highlight:true;">
                  #{highlight.content}
                </i>
              </div>
            </blockquote>
            <i><br/></i>
          CONTENT
        end
        @result[book_title] = note_content
      end

      @result
    end

    private
    def clippings_file_path
      case Gem::Platform.local.os
      when "darwin"
        "/Volumes/Kindle/documents/My\ Clippings.txt"
      when "linux"
        "/media/#{ENV["USER"]}/Kindle/documents/My\ Clippings.txt"
      end
    end
  end
end

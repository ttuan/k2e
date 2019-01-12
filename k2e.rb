require "kindleclippings"
require "dotenv/load"
require "mail"
require "time"
require "pry"

options = {
  address: "smtp.gmail.com",
  port: 587,
  user_name: ENV["GMAIL_USERNAME"],
  password: ENV["GMAIL_PASSWORD"],
  authentication: "plain",
  enable_starttls_auto: true
}

Mail.defaults do
  delivery_method :smtp, options
end

def create_evernote_note subject_content, body_content
  Mail.deliver do
    to ENV["EVERNOTE_MAIL"]
    from ENV["GMAIL_USERNAME"]
    subject subject_content
    html_part do
      content_type "text/html; charset=UTF-8"
      body body_content
    end
  end
end

def last_sync_date
  file_name = "./last_sync_date.txt"
  unless File.file?(file_name)
    File.open(file_name, "w") {|file| file.write("1970-01-01T00:00:00+07:00")}
  end

  @sync_date ||= DateTime.parse File.read(file_name)
end

def update_last_sync_date
  file_name = "./last_sync_date.txt"
  File.open(file_name, "w") {|file| file.write(DateTime.now)}
end

def parse_highlights
  parser = KindleClippings::Parser.new

  clippings = parser.parse_file("My Clippings.txt")
  highlights = clippings.highlights.delete_if{|highlight| highlight.added_on < last_sync_date}

  highlights.group_by(&:book_title).each do |book_title, book_highlights|
    next if book_highlights.empty?

    subject_content = "#{book_title} @#{ENV["NOTEBOOK"]} #notes +"
    body_content = ""

    book_highlights.each do |highlight|
      str_date = Time.parse highlight.added_on.to_s
      body_content += <<-HEREDOC
        <div>A highlight is created on #{str_date}, starting at location #{highlight.location} </div>

        <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
          <div>
            <i style="background-color:rgb(255, 250, 165);-evernote-highlight:true;">
              #{highlight.content}
            </i>
          </div>
        </blockquote>
        <i><br/></i>
      HEREDOC
    end

    create_evernote_note subject_content, body_content
  end

  update_last_sync_date
end

parse_highlights

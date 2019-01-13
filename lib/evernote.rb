# Inspired from https://github.com/zdogma/kindle-highlights/blob/master/lib/evernote.rb

require "dotenv/load"
require "evernote_oauth"

module Evernote
  class Client
    attr_reader :token, :note_store

    def initialize
      @token = ENV["EVERNOTE_DEV_TOKEN"]
      @note_store = ::EvernoteOAuth::Client.new(token: @token, sandbox: false).note_store
    end
  end

  class Note
    attr_reader :note_store, :title, :content, :notebook

    OFFSET = 0
    MAX_RESULT_NUM = 1

    def initialize title:, content:, notebook_name:
      @note_store = ::Evernote::Client.new.note_store
      @title = title
      @content = format_xml content
      @notebook = find_notebook notebook_name
    end

    def update
      new_note = Evernote::EDAM::Type::Note.new

      new_note.title = title
      new_note.content = content

      filter = Evernote::EDAM::NoteStore::NoteFilter.new words: title
      found_note = note_store.findNotes(::Evernote::Client.new.token, filter, OFFSET, MAX_RESULT_NUM).notes.first

      if found_note
        full_note_content = note_store.getNote(::Evernote::Client.new.token, found_note.guid, true, true, false, false)
        new_note.guid = found_note.guid
        new_note.content = full_note_content.content + new_note.content
        note_store.updateNote(::Evernote::Client.new.token, new_note)
      else
        new_note.notebookGuid = notebook.guid
        note_store.createNote new_note
      end

      new_note
    rescue Evernote::EDAM::Error::EDAMUserException => e
      puts "EDAMUserException: #{e}"
    end

    private
    def find_notebook notebook_name
      note_store.listNotebooks.find {|notebook| notebook.name == notebook_name}
    end

    def format_xml content
      <<-HEADER
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">
<en-note>#{content}</en-note>
      HEADER
    end
  end
end

FROM ruby:2.5.1

RUN gem install kindleclippings dotenv evernote_oauth

COPY . /opt/kindle-to-evernote/

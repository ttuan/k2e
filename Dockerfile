FROM ruby:2.5.1

# RUN apt-get install -y build-essential

RUN gem install kindleclippings dotenv

COPY . /opt/kindle-to-evernote/

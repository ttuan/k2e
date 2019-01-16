FROM ruby:2.5.1

COPY . /opt/kindle-to-evernote/

WORKDIR /opt/kindle-to-evernote
RUN bundle install

ENTRYPOINT ["ruby", "k2e.rb"]

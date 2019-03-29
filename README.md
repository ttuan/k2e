# Kindle to Evernote

A tool allows you sync Kindle highlights to Evernote

## Installation

```ruby
gem install k2e
```

## Setup

To start, you need to config below environment variables to your shell config
file (`~/.zshrc`, `~/.bashrc`, ..):

```
# Notebook name, which stores Kindle highlights
NOTEBOOK="Kindle"
# Evernote dev token, get it here: https://www.evernote.com/api/DeveloperToken.action
EVERNOTE_DEV_TOKEN="EVERNOTE_DEV_TOKEN"
# Optional.
# We need to store last sync date, to avoid duplicated data. Storing this date allow you use synchronize command anywhere :D
# Default path is "~/.k2e/last_syn_date.txt
K2E_DATA_LOCATION="/Users/ll/Dropbox/App/k2e/last_syn_date.txt"
```

## Usage

1. Plug Kindle to your computer.
2. Open terminal, run this command: `k2e`

If you are using Mac OS, you can follow [this
guide](http://www.jamierubin.net/2014/03/19/going-paperless-prototype-automatically-send-kindle-notes-and-highlights-to-evernote/), using Keyboard Maestro to trigger Kindle pluging action.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ttuan/k2e.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

require 'daemons'

Daemons::Monitor.start [Daemons.run('instagram.rb'), Daemons.run('tweetstream.rb')]
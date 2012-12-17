require 'bluepill'

Bluepill.application 'lipstagram' do |app|
  app.process 'twitter_parser' do |process|
    process.start_command = 'ruby script/tweetstream.rb start'
    process.start_command = 'ruby script/tweetstream.rb start'
    process.pid_file = '/tmp/twitter_parser.pid'
    process.daemonize = true
    process.checks :cpu_usage, every: 5.seconds, below: 10, times: [7,10]
    process.checks :mem_usage, every: 5.seconds, below: 100.megabytes, times: [7,10]
  end
  app.process 'instagram_parser' do |process|
    process.start_command = 'ruby script/instagram.rb start'
    process.pid_file = '/tmp/instagram_parser.pid'
    process.daemonize = true
    process.checks :cpu_usage, every: 5.seconds, below: 10, times: [7,10]
    process.checks :mem_usage, every: 5.seconds, below: 100.megabytes, times: [7,10]
  end
  app.process 'server' do |process|
    process.start_command = 'thin start -p 80 -e production -d'
    process.pid_file = '/tmp/thin.pid'
    process.daemonize = true
  end
end

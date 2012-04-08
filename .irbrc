require 'rubygems' rescue nil
require 'irb/completion'

script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
 require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end

@working_directory = Dir.pwd
@local_irbrc = File.join(@working_directory, '.irbrc')

if @working_directory != ENV['HOME']
  load @local_irbrc if File.exists?(@local_irbrc)
end

remove_instance_variable(:@working_directory)
remove_instance_variable(:@local_irbrc)

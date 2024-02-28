require_relative "lib/quake-log-parser"
require 'active_support/all'

task :kill_reports do
  parser = LogParser.new("resources/qgames.log")
  parser.parse

  parser.matches.each_with_index do |match, i|
    puts "\n\n --- Match #{i+1} --- \n\n"
    pp match.kill_report
  end
end

task :kill_reports_by_cause do
  parser = LogParser.new("resources/qgames.log")
  parser.parse

  parser.matches.each_with_index do |match, i|
    puts "\n\n --- Match #{i+1} --- \n\n"
    pp match.kill_report_by_death_reason
  end
end
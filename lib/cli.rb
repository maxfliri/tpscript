require 'optparse'

module Cli

  def self.options!(args = ARGV)

    options = {}

    OptionParser.new do |opts|
      opts.banner = <<-STRING.gsub(/^ +/, '')
      Extracts from TargetProcess the cumulative flow for a specific team, and prints it in CSV format

      Usage:   #{$PROGRAM_NAME} [options]

      STRING

      opts.on("-t", "--team TEAM_ABBREVIATION", "(required) select a team to filter the data") do |team|
        options[:team] = team
      end

      opts.on("-u", "--username USERNAME", "(required) username to log on TargetProcess") do |username|
        options[:username] = username
      end

      opts.on("-p", "--password PASSWORD", "(required) password to log on TargetProcess") do |password|
        options[:password] = password
      end

      opts.on("-b", "--base-uri URI", "(required) URI of TargetProcess") do |uri|
        options[:base_uri] = uri
      end

      opts.on("--states STATES", "included states, separated by commas") do |states|
        options[:states] = states.split(',').map(&:chomp)
      end

      options[:day] = "tuesday"
      opts.on("-d", "--day DAY", %w{monday tuesday wednesday thursday friday saturday sunday},
              "day of week used as iteration start (defaults to tuesday)") do |day|
        options[:day] = day
      end
    end.parse!(args)

    options
  end
end

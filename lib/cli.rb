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

      opts.on("-p", "--project PROJ_ABBREVIATION", "(required) select a project to filter the data") do |project|
        options[:project] = project
      end

      opts.on("-u", "--username USERNAME", "(required) username to log on TargetProcess") do |username|
        options[:username] = username
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

      options[:verify] = true
      opts.on("--[no-]verify", "verify ssl certificates") do |verify|
        options[:verify] = verify
      end

    end.parse!(args)

    unless options[:username] then
      options[:username] = get_input("Username: ")
    end

    options[:password] = get_input("Password: ", echo: false)

    options
  end

  private

  def self.get_input(prompt, echo: true)
    $stderr.print prompt
    if echo then
      $stdin.gets.chomp
    else
      input = $stdin.noecho(&:gets).chomp
      puts
      input
    end
  end
end

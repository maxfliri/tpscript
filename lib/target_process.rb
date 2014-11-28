require 'date'
require 'httparty'
require 'json'
require 'uri'

class TargetProcess

  def initialize(username: nil, password: nil, base_uri: nil, verify_ssl_certs: true)
    @username = username
    @password = password
    @base_uri = base_uri
    @verify_ssl_certs = verify_ssl_certs
  end

  def user_stories(team_abbr)
    get_items "#{@base_uri}/api/v1/UserStories?format=json&where=Team.Abbreviation%20eq%20%27#{team_abbr}%27"
  end

  def story_history(id)
    get_items("#{@base_uri}/api/v1/UserStories/#{id}/History?format=json").map {|i| i.tap {|i| i["Date"] = parse_date(i["Date"]) }}
  end

  private

  def parse_date(date)
    match = /\/Date\(([0-9]+)([+-][0-9]+)\)\//.match date
    DateTime.strptime(match[1], "%Q")
  end

  def get_items(url)
    json = get(url)

    if json.has_key? "Next" then
      json["Items"] + get_items(URI.escape(json["Next"]))
    else
      json["Items"]
    end
  end

  def get(url)
    $stderr.puts "Getting #{url}..."
    response = HTTParty.get(url, basic_auth: {username: @username, password: @password}, verify: @verify_ssl_certs)
    JSON.parse(response.body)
  end

end

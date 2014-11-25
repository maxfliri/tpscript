require 'csv'
require 'date'
require 'set'

class CumulativeFlow

  def initialize(user_story_history, states: nil)
    @data = dates(user_story_history).map {|date| {"Date" => date}.merge(effort_by_state(snapshot(user_story_history, date))) }
    @states = states || all_states(user_story_history)
  end

  def to_csv
    CSV.generate do |csv|
      csv << [''] + @states
      @data.each do |i|
        csv << [ i["Date"] ] + @states.map {|state| i[state] || 0.0}
      end
    end
  end

  private

  def snapshot(history, date)
    history.reject {|i| i["Date"] >= date}.group_by {|i| i["UserStory"]["Id"] }.values.map {|a| a.max_by {|i| i["Date"]}}
  end

  def effort_by_state(snapshot)
    stories_by_state = snapshot.group_by {|i| i["EntityState"]["Id"] }.values

    stories_by_state.hmap do |stories|
      state_name = stories.first["EntityState"]["Name"]
      cumulated_effort = stories.map {|i| i["Effort"]}.reduce(:+)
      [state_name, cumulated_effort]
    end
  end

  def all_states(history)
    history.reduce(Set.new) {|states, i| states << i["EntityState"]["Name"] }.to_a
  end

  def last_tuesday
    d = Date.today
    d = d-1 while not d.tuesday?
    d
  end

  def dates(history)
    start = last_tuesday
    stop = history.map {|i| i["Date"]}.min
    dates = start.step(stop, -7).to_a.reverse
  end
end

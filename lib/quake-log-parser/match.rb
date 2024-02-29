class Match
  attr_accessor :events, :players, :kills, :end_game_reason

  def initialize
    @events = []
    @players = []
  end

  def add_event(event)
    events << event

    if event.player_connect?
      new_player = Player.new(event.player_name) 
      unless players.find { |player| player.name == new_player.name }
        players << new_player
      end
    elsif event.kill?
      killer = players.find { |player| player.name == event.killer }
      killed = players.find { |player| player.name == event.killed }

      kill = Kill.new(killer, killed, event.reason)

      if killer
        killer.kills << kill
      else
        killed.world_deaths << kill
      end
    elsif event.end_game?
      @end_game_reason = event.end_game_reason
    end
  end

  def kills
    @kills ||= players.flat_map(&:kills_and_world_deaths)
  end

  def kill_report
    score = {}
    total_kills = 0
    player_names = []

    players.each do |player|
      score[player.name] = player.score
      player_names << player.name
      total_kills += player.kills_and_world_deaths.count
    end

    {
      total_kills: total_kills,
      players: player_names,
      kills: score
    }
  end

  def kill_report_by_death_reason
    kills_by_reason = Hash.new(0)
    kills.each { |kill| kills_by_reason[kill.reason] += 1 }
    kills_by_reason
  end
end
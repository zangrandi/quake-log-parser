class Player
  attr_accessor :name, :kills, :world_deaths, :score

  def initialize(name)
    @name = name
    @kills = []
    @world_deaths = []
  end

  def score
    valid_kills.count - world_deaths.count
  end

  def valid_kills
    kills.select { |kill| kill.killed != self }
  end

  def kills_and_world_deaths
    kills + world_deaths
  end
end
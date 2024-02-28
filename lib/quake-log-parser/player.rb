class Player
  attr_accessor :name, :kills, :world_deaths, :score

  def initialize(name)
    @name = name
    @kills = []
    @world_deaths = []
  end

  def score
    kills.count - world_deaths.count
  end

  def kills_and_world_deaths
    kills + world_deaths
  end
end
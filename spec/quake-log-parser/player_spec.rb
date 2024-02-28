require_relative '../spec_helper'

describe Player do
  let(:player) { Player.new("Isgalamido") }

  before do
    player.kills = [
      Kill.new("Isgalamido", "Zeh", "MOD_ROCKET_SPLASH"), 
      Kill.new("Isgalamido", "Mocinha", "MOD_ROCKET_SPLASH"),
      Kill.new("Isgalamido", "Dono da Bola", "MOD_ROCKET_SPLASH"),
    ]
    player.world_deaths = [
      Kill.new("<world>", "Isgalamido", "MOD_TRIGGER_HURT")
    ]
  end

  context "#name" do
    it "should have a name" do
      expect(player.name).to eq("Isgalamido")
    end
  end

  context "#score" do
    it "should have a score" do
      expect(player.kills.length).to eq(3)
      expect(player.world_deaths.length).to eq(1)
      expect(player.score).to eq(2)
    end
  end

  context "#kills_and_world_deaths" do
    it "should return both kills and world deaths" do
      expect(player.kills_and_world_deaths).to eq(player.kills + player.world_deaths)
    end
  end
end
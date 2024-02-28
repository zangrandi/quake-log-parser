require_relative '../spec_helper'

describe Kill do
  let(:player1) { Player.new("Zeh") }
  let(:player2) { Player.new("Assasinu Credi") }
  let(:kill) { Kill.new(player1, player2, "MOD_ROCKET_SPLASH") }

  it "should identify the killer" do
    expect(kill.killer).to eq(player1)
  end

  it "should identify the killed player" do
    expect(kill.killed).to eq(player2)
  end

  it "should identify the reason" do
    expect(kill.reason).to eq("MOD_ROCKET_SPLASH")
  end
end
require_relative '../spec_helper'

describe Match do
  let(:match) { Match.new }
  let(:player1) { Player.new("Zeh") }
  let(:player2) { Player.new("Assasinu Credi") }
  let(:kill1) { Kill.new(player1, player2, "MOD_TRIGGER_HURT") }
  let(:kill2) { Kill.new(player2, player1, "MOD_RAILGUN") }
  let(:world_death) { Kill.new(nil, "Isgalamido", "MOD_TRIGGER_HURT") }

  before do
    match.players = [player1, player2]
    player1.kills = [kill1]
    player1.world_deaths = [world_death]
    player2.kills = [kill2]
  end

  context "#add_event" do
    context "player connect" do
      let(:event) { 
        Event.new('20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/') 
      }

      it "should add player connect event" do
        match.add_event(event)
        expect(match.players.length).to eq(3)
        expect(match.players.last.name).to eq("Isgalamido")
      end

      it "should not add repetead players" do
        match.add_event(event)
        match.add_event(event)
        expect(match.players.length).to eq(3)
      end
    end

    context "kill" do
      let(:event) { Event.new("5:54 Kill: 6 5 7: Zeh killed Assasinu Credi by MOD_ROCKET_SPLASH") }

      it "should add kill event" do
        match.add_event(event)
        expect(player1.kills.length).to eq(2)
        expect(player1.kills.last.killer).to eq(player1)
        expect(player1.kills.last.killed).to eq(player2)
        expect(player1.kills.last.reason).to eq("MOD_ROCKET_SPLASH")
      end
    end

    context "end game" do
      let(:event) { Event.new("13:55 Exit: Fraglimit hit.") }

      it "should add end game event" do
        match.add_event(event)
        expect(match.end_game_reason).to eq("Fraglimit")
      end
    end
  end

  context "#kills" do
    it "should return kills from all players" do
      expect(match.kills).to eq([kill1, world_death, kill2])
    end
  end

  context "#kill_report" do
    it "should return correct report of kills" do
      expect(match.kill_report).to eq(
        {
          total_kills: 3,
          players: ["Zeh", "Assasinu Credi"],
          kills: {
            "Zeh" => 0,
            "Assasinu Credi" => 1,
          }
        }
      )
    end 
  end

  context "#kill_report_by_death_reason" do
    it "should return correct report of kills by reason" do
      expect(match.kill_report_by_death_reason).to eq(
        {
          "MOD_TRIGGER_HURT" => 2,
          "MOD_RAILGUN" => 1,
        }
      )
    end
  end
end
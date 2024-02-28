require_relative '../spec_helper'

describe Event do
  context "#kill?" do
    it "should identify kill lines" do
      line = "5:54 Kill: 6 5 7: Zeh killed Assasinu Credi by MOD_ROCKET_SPLASH"
      expect(Event.new(line).kill?).to eq(true)
    end

    it "should identify non kill lines" do
      line = "5:54 Exit: Fraglimit hit."
      expect(Event.new(line).kill?).to eq(false)
    end
  end

  context "#init_game?" do
    it "should identify init game lines" do
      line = '6:10 InitGame: \capturelimit\8\g_maxGameClients\0\timelimit\15'
      expect(Event.new(line).init_game?).to eq(true)
    end

    it "should identify non init game lines" do
      line = "5:55 Item: 3 item_health_large"
      expect(Event.new(line).init_game?).to eq(false)
    end
  end

  context "#end_game?" do
    it "should identify end game lines" do
      line = "13:55 Exit: Fraglimit hit."
      expect(Event.new(line).end_game?).to eq(true)
    end

    it "should identify non end_game lines" do
      line = "6:10 ClientUserinfoChanged: 3 "
      expect(Event.new(line).end_game?).to eq(false)
    end
  end

  context "#player_connect?" do
    it "should identify player connect lines" do
      line = '20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/'
      expect(Event.new(line).player_connect?).to eq(true)
    end

    it "should identify non player connect lines" do
      line = "6:10 ClientUserinfoChanged: 3 "
      expect(Event.new(line).player_connect?).to eq(false)
    end
  end

  context "#end_game_reason" do
    it "should get end game reason" do
      line = "13:55 Exit: Fraglimit hit."
      expect(Event.new(line).end_game_reason).to eq("Fraglimit")
    end

    it "should identify non player connect lines" do
      line = "6:10 ClientUserinfoChanged: 3 "
      expect(Event.new(line).end_game_reason).to eq(nil)
    end
  end
end
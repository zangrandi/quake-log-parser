class Event
  attr_accessor :line

  INIT_GAME_REGEX = /InitGame/
  END_GAME_REGEX = /Exit: (\w*) hit/
  PLAYER_CONNECT_REGEX = /ClientUserinfoChanged: \d* n\\([\w\s]*)\\t/
  KILL_REGEX = /Kill: \d* \d* \d*: (.*) killed (.*) by (.*)/

  def initialize(line)
    @line = line
  end

  def valid?
    init_game? || end_game? || kill? || player_connect?
  end

  def init_game?
    (line =~ INIT_GAME_REGEX).present?
  end

  def end_game?
    (line =~ END_GAME_REGEX).present?
  end

  def kill?
    (line =~ KILL_REGEX).present?
  end

  def player_connect?
    (line =~ PLAYER_CONNECT_REGEX).present?
  end

  def player_name
    return unless player_connect?
    line.match(PLAYER_CONNECT_REGEX)[1]
  end

  def end_game_reason
    return unless end_game?
    line.match(END_GAME_REGEX)[1]
  end

  def killer
    return unless kill?
    line.match(KILL_REGEX)[1]
  end

  def killed
    return unless kill?
    line.match(KILL_REGEX)[2]
  end

  def reason
    return unless kill?
    line.match(KILL_REGEX)[3]
  end

end
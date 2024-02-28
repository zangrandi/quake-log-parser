class LogParser
  attr_accessor :file_path, :matches

  def initialize(file_path)
    @file_path = file_path
    @matches = []
  end

  def parse    
    File.open(file_path, "r") do |file|
      current_match = nil

      file.each_line do |line|
        event = Event.new(line)

        if event.init_game?
          current_match = Match.new
        end

        if current_match && event.valid?
          current_match.add_event(event)
        end

        # Consider as valid matches only the ones that actually ended due to a reason
        # Does not consider premature disconnects as valid matches
        if event.end_game?
          matches << current_match
          current_match = nil
        end
      end
    end
  end
end
class Move
  COUNTRIES = %w(england france germany italy austria russia turkey)

  class << self
    def collection
      @@collection ||= {moves: [], numbers: []}
    end

    def collection=(arg)
      @@collection = arg
    end

    def reset_collection!
      @@collection = {moves: [], numbers: []}
      return nil # don't want to render the collection if Move.end_round! is the last method in the call stack
    end

    def end_round! # sends sms
      round_info = "ROUND OVER\n" + Move.collection[:moves].join("\n")
      Move.collection[:numbers].each {|number| Responses.send_string(round_info, number)}
      Move.reset_collection!
    rescue
      raise Errors::EndRoundError
    end
  end

  def initialize(move, from)
    raise Errors::MoveParseError if !COUNTRIES.any? {|country| move.match /#{country}/i }
    add_to_current_round(move, from)
  end


  private

  def add_to_current_round(move, from)
    moves   = Move.collection[:moves] << move
    numbers = Move.collection[:numbers] << from
    Move.collection = {moves: moves, numbers: numbers}
  end
end
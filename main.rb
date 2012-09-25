Dir.glob('lib/*.rb'){|f| require_relative f}
Game.new(ArgParser.parse(ARGV)).run

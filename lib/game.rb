class Game
  attr_reader :board

  def initialize(options = {})
    options   = {width: 5, height: 5, speed: 100, rounds: 100, random: true, prob: 10, file: nil}.merge(options)
    @rounds   = options[:rounds].to_i
    @interval = (options[:speed].nil? ? 0 : (2.0 / options[:speed].to_i))
    if options[:file]
      width   = options[:file].shift.index('#') + 1
      height  = options[:file].size
      @board  = ::Board.new width, height
      board.populate options[:file]
    else
      @board  = ::Board.new options[:width], options[:height]
      board.randomize(options[:prob]) if options[:random]
    end
    display
  end
  
  def tick
    # @board.walk{ |cell| cell.find_next_state }
    threads = @board.walk{ |cell| Thread.new{cell.find_next_state} }
    threads.each(&:join)
  end
  
  def tock
    @board.walk{ |cell| cell.switch_state }
  end
  
  def run
    start = Time.now.to_f
    @rounds.times do |n|
      tick; tock; display((n+1), start)
      sleep @interval
    end
  end
  
  def display(round = 0, time = Time.now.to_f)
    puts "\e[H\e[2J"
    print @board.to_s + "Life: #{@board.life} / #{@board.size}, Round: #{round} / #{@rounds}, FPS: #{round.to_f / (Time.now.to_f - time)}"
  end
end

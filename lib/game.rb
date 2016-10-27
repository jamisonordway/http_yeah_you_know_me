class Game

  attr_reader :number, :guess
  attr_accessor :guess_count

  def initialize
    @guess = nil
    @number = rand(0..100)
    @guess_count = 0
  end

  def write_response(requests)
    response = "Number of guesses: #{guess_count} <br>Guess:#{guess}<br>Guess was #{guess_compare}"
    "<html><head></head><body>Number of Requests:#{requests}</p><h1>#{response}</h1></body></html>"
  end

  def guess_compare
    case number <=> guess
      when 1
        "too high."
      when -1
        "too low."
      when 0
        "correct!"
    end
  end

  def guesser(number)
    @guess = number
    @guess_count += 1
  end

end
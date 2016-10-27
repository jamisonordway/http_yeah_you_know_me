class Game

  attr_reader :number, :guess_count, :guess

  def initialize
    @guess = nil
    @number = rand(0..100)
    @guess_count = 0
  end

  def response
    "Number of guesses: #{guess_count}. <br>Guess was #{guess_compare}"
  end

  def guess_compare
    case guess <=> number
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
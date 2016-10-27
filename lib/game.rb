class Game

  attr_reader :number, :guess

  def initialize(guess)
    @guess = guess
    @number = rand(0..100)
  end

end
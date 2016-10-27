require 'minitest/pride'
require 'minitest/autorun'
require './lib/game'

class GameTest < Minitest::Test

  attr_reader :game

  def setup
    @game = Game.new
  end

  def test_it_pulls_random_number_in_range
    result = game.number

    assert (0..100).to_a.include?(result)
  end

  def test_it_can_add_to_guess_counter
    assert_equal 0, game.guess_count

    game.guesser(42)

    assert 1, game.guess_count
  end

  def test_it_can_compare_guess_to_number
    game.guesser(42)
    result = game.guess_compare

    assert_equal String, result.class
  end


  def test_it_returns_response
    game.guesser(42)
    
    assert game.response.include?("Number of guesses: 1. <br>Guess was")
  end

end
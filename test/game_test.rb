require 'minitest/pride'
require 'minitest/autorun'
require './lib/game'

class GameTest < Minitest::Test

  attr_reader :game

  def setup
    @game = Game.new(42)
  end

  def test_it_pulls_random_number_in_range
    result = game.number

    assert (0..100).to_a.include?(result)
  end

  def test_it_can_take_guess
    result = game.guess

    assert 42, result
  end

  def test_it_can_compare_guess_to_number
    result = game.compare_guess
  end

end
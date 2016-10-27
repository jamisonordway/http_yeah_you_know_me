require 'faraday'
require 'minitest/pride'
require 'minitest/autorun'
require './lib/server'

class ServerTest < Minitest::Test

  def test_its_status_is_200
    response = Faraday.get('http://localhost:9292/')
    assert_equal 200, response.status
  end

  def test_body_of_response_has_diagnostics_as_default_body
    response = Faraday.get('http://localhost:9292/')
    assert response.body.include?('GET')
  end

  def test_it_can_follow_path_to_hello
    response = Faraday.get('http://localhost:9292/hello')
    assert response.body.include?("Hello")
  end

  def test_it_can_follow_path_to_datetime
    response = Faraday.get('http://localhost:9292/datetime')
    assert response.body.include?("2016")
  end

  def test_it_runs_word_seach_when_passed_path_and_params
    response = Faraday.get('http://localhost:9292/wordsearch?word=why')
    assert response.body.include?("WHY is a known word")
  end

  def test_it_can_start_a_game_given_correct_path
    response = Faraday.get('http://localhost:9292/start_game')

    assert response.body.include?("Good Luck!")
  end

  def it_can_return_guess_response
    Faraday.get('http://localhost:9292/start_game')
    response = response = Faraday.guess('http://localhost:9292/game?guess=42')

    assert response.body.include?("Number of guesses") 
  end

  def test_it_can_redirect_given_a_guess
    Faraday.get('http://localhost:9292/start_game')
    response = Faraday.post('http://localhost:9292/game?guess=42')

    assert response.body.include?("Number of guesses")
  end

end



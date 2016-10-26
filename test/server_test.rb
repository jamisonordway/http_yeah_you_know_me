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

end



require './test/test_helper'
require './lib/word_search'

class WordSearchTest < MiniTest::Test

  attr_reader :search

  def setup 
    @search = WordSearch.new
  end

  def test_it_stores_params_as_word
    search.pull_word('/wordsearch?word=why')
    assert_equal 'why', search.word
  end

  def test_it_can_confirm_a_word_is_in_dictionary
    search.pull_word('/wordsearch?word=why')
    result = search.search_in_dictionary

    assert_equal true, result
  end

  def test_it_can_know_when_a_word_is_not_in_dictionary
    search.pull_word('/wordsearch?word=iqyt')
    result = search.search_in_dictionary

    assert_equal false, result
  end

  def test_it_can_send_correct_response_if_it_finds_right_word
    search.pull_word('/wordsearch?word=why')
    result = search.send_correct_response(true)

    assert_equal "WHY is a known word", result
  end

end
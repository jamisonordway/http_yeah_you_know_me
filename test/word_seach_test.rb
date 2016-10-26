require 'minitest/pride'
require 'minitest/autorun'
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

end
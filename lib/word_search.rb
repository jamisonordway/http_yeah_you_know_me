class WordSearch

  attr_reader :word

  def pull_word(path)
    @word = path.split('/wordsearch?word=')[1]
  end

end
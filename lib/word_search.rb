require 'pry'

class WordSearch

  attr_reader :word

  def find_word(path)
    pull_word(path)
    boolean = search_in_dictionary
    send_correct_response(boolean)
  end

  def pull_word(path)
    @word = path.split('/wordsearch?word=')[1]
  end

  def search_in_dictionary
    file = File.open('/usr/share/dict/words', 'r')
    dictionary = file.readlines.map {|word| word.chomp} 
    dictionary.include?(word)
  end

  def send_correct_response(boolean)
    if boolean == true
      "#{word.upcase} is a known word"
    else
      "#{word.upcase} is not a known word"
    end
  end

end
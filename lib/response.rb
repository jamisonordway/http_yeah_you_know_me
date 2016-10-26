require './lib/word_search'

class Response

  attr_reader :path, :diagnostics, :header, :output, :hellos, :requests

  def initialize(diagnostics, path, hellos, requests)
    @diagnostics = diagnostics
    @path = path
    @hellos = hellos
    @requests = requests
    @header = nil
    @output = nil
  end

  def write_output(path_file)
    response = "#{diagnostics.join("<br>")}"
    output = "<html><head></head><body><p>#{response}<br>Number of Requests:#{requests}</p><h1>#{path_file}</h1></body></html>"
  end

  def write_header(output)
    headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def determine_output_from_path
    case path
      when '/'
        output = write_output("")
      when '/hello'
        output = write_output("Hello, World (#{hellos})")
      when '/datetime'
        output = write_output("#{Time.now.strftime('%l:%M%p')} on #{Time.now.strftime('%A, %B %d, %Y')}")
      when '/shutdown'
        output = write_output("Total Number of Requests #{requests}")
      when includes?('/wordsearch?word=')
        search = WordSearch.new(path)
        search.find_word(path)
        if search == true
      else
        output = write_output("Not a valid path")
    end
  end

end
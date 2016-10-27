require 'socket'
require 'pry'
require './lib/parser'
require './lib/response'


class Server

  attr_reader :tcp_server, :parser, :game
  attr_accessor :hello_counter, :request_counter

  def initialize
    @tcp_server = TCPServer.new(9292)
    @parser = Parser.new
    @hello_counter = 0
    @request_counter = 0
  end

  def start
    while 
      client = tcp_server.accept
      diagnostics_list = pull_request_lines(client)
      add_to_counters
      response = Response.new(diagnostics_list, path, hello_counter, request_counter)
      game_starter
      output = response.determine_output_from_path 
      game_guess(diagnostics_list, client) if game 
      output = game.write_response(request_counter) if path == "/game"
      client.puts response.write_header(output)
      client.puts output
      shutdown?(client)
    end
  end

  def pull_request_lines(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    parser.format_request_lines(request_lines)
  end
  
  def path
    parser.diagnostics["Path"]
  end

  def verb
    parser.diagnostics["Verb"]
  end

  def add_to_counters
    if path == "/hello"
      @hello_counter += 1
      @request_counter += 1
    else
      @request_counter += 1
    end
  end

  def game_starter
    @game = Game.new if path == "/start_game"
  end

  def game_guess(diagnostics_list, client)
    if path == "/game" && verb == "POST"
      length = get_content_length(diagnostics_list)
      number = client.read(length) 
      game.guesser(number.to_i)
      redirect(client)
    end
  end

  def get_content_length(diagnostics_list)
    content_length = diagnostics_list.find {|line| line.include?('Content-Length')}
    content_length.split(':')[-1].to_i
  end

  def redirect(client)
    header = ['HTTP/1.1 301 Moved Permanently',
              'location: http://localhost:9292/game',
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1\r\n\r\n"].join("\r\n")
    client.puts header 
  end

  def shutdown?(client)
    if path == "/shutdown" || request_counter == 12
      tcp_server.close
    else
      client.close
    end
  end


end



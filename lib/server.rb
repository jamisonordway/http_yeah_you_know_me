require 'socket'
require 'pry'
require './lib/parser'
require './lib/response'


class Server

  attr_reader :tcp_server, :parser
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
      response = Response.new(diagnostics_list, parser.diagnostics['Path'], hello_counter, request_counter)
      output = response.determine_output_from_path
      client.puts response.write_header(output)
      client.puts output
      shutdown?
    end
  end

  def pull_request_lines(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    parser.format_request_lines(request_lines)
  end

  def add_to_counters
    if parser.diagnostics["Path"] == "/hello"
      @hello_counter += 1
      @request_counter += 1
    else
      @request_counter += 1
    end
  end

  def shutdown?
    if parser.diagnostics["Path"] == "/shutdown" || request_counter == 12
      tcp_server.close
    else
      client.close
    end
  end


end



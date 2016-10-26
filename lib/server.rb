require 'socket'
require 'pry'
require './lib/parser'
require './lib/response'


class Server

  attr_reader :tcp_server, :parser
  attr_accessor :hello_counter

  def initialize
    @tcp_server = TCPServer.new(9292)
    @hello_counter = 0
    @parser = Parser.new
  end

  def pull_request_lines(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    parser.format_request_lines(request_lines)
  end

  def start
    while 
      client = @tcp_server.accept
      @hello_counter += 1
      diagnostics_list = pull_request_lines(client)
      response = Response.new(diagnostics_list, parser.diagnostics['Path'])
      client.puts response.header
      client.puts response.output
      client.close
    end
  end

end



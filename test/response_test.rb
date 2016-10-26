require 'minitest/autorun'
require 'minitest/pride'
require './lib/response.rb'

class ResponseTest < Minitest::Test

  attr_reader :path_root, :diagnostics_lines

  def setup
    @path_root = "/"
    @diagnostics_lines = ["Verb: GET",
                                "Path: /",
                                "Protocol: HTTP/1.1",
                                "Host: localhost:9292",
                                "Connection: keep-alive",
                                "Cache-Control: no-cache",
                                "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36",
                                "Postman-Token: e7c09f0e-dea2-c5cb-b5f4-446d68a44429",
                                "Accept: */*",
                                "Accept-Encoding: gzip, deflate, sdch",
                                "Accept-Language: en-US,en;q=0.8,fr;q=0.6"]
  end

  def test_it_takes_in_path
    response = Response.new(diagnostics_lines, path_root)
    result = response.path

    assert_equal '/', result
  end

  def test_it_can_write_correct_ouput_given_root_path_file
    response = Response.new(diagnostics_lines, path_root)
    result = response.write_output("")

    assert_equal "<html><head></head><body><pre>#{diagnostics_lines}</pre><h1>""</h1></body></html>", result
  end

  def test_it_can_write_correct_response_given_hello_path_file
    response = Response.new(diagnostics_lines, path_root)
    result = response.write_output("Hello, World")

    assert_equal "<html><head></head><body><pre>#{diagnostics_lines}</pre><h1>Hello, World</h1></body></html>", result
  end

  def test_it_can_write_correct_response_given_datetime_path_file
    response = Response.new(diagnostics_lines, path_root)
    result = response.write_output("Hello, World")

    assert_equal "<html><head></head><body><pre>#{diagnostics_lines}</pre><h1>Hello, World</h1></body></html>", result
  end
end
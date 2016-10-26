class Response

  attr_reader :path, :diagnostics, :header, :output

  def initialize(diagnostics, path)
    @diagnostics = diagnostics
    @path = path
    @header = nil
    @output = nil
  end

  def write_output(path_file)
    response = "<pre>" + "#{diagnostics}" + "</pre>"
    output = "<html><head></head><body>#{response}<h1>#{path_file}</h1></body></html>"
  end

  def write_header(output)
    headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def determine_path
    case path
      when '/'
        output = write_output("")
        header = write_header(output)
      when '/hello'
        output = write_output("Hello, World")
        header = write_header(output)
      when '/datetime'
        output = write_output("")
        header = write_header(output)
      when '/shutdown'
    end
  end

end
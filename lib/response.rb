class Response

  attr_reader :path, :diagnostics, :header, :output

  def initialize(diagnostics, path)
    @diagnostics = diagnostics
    @path = path
    @header = nil
    @output = nil
  end

  def write_output(path_file)
    response = "<pre>" + "#{diagnostics.each {|line| }}" + "</pre>"
    output = "<html><head></head><body>#{response}<h1>#{path_file}</h1></body></html>"
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
        output = write_output("Hello, World")
      when '/datetime'
        output = write_output("#{Time.now.strftime('%l:%M%p')} on #{Time.now.strftime('%A, %B %d, %Y')}")
      when '/shutdown'
        output = write_output("Shutting Down")
      else
        output = write_output("Not a valid path")
    end
  end

end
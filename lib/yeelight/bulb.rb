require 'json'

module Yeelight
  class Bulb
    attr_accessor :host, :port
    def initialize(host, port: 55443)
      @host = host
      @port = port
    end

    def get_prop(values)
      cmd = "{\"id\":1,\"method\":\"get_prop\",\"params\":[#{values}]}\r\n"
      request(cmd)
    end

    private

    def request(cmd)
      begin
        s = TCPSocket.open(host, port)
        s.puts cmd
        data = s.gets.chomp
        s.close
        response(data)
      rescue Exception => msg
        response(JSON.generate(exception: msg))
      end
    end

    def response(data)
      json = JSON.parse(data)
      result = {
        status: json['result'] ? true : false,
        data: json
      }
      JSON.generate(result)
    end
  end
end

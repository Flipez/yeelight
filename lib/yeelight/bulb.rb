require 'json'

module Yeelight
  class Bulb
    attr_accessor :host, :port
    def initialize(host, port: 55443)
      @host = host
      @port = port
    end

    def on?
      res = get_prop('power')
      res.first == 'on'
    end

    def off?
      res = get_prop('power')
      res.first == 'off'
    end

    def get_prop(values)
      cmd = call(1, 'get_prop', values)
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
      json['result']
    end

    def call(id, method, params)
      params = [params] unless params.class == Array
      { id: id,
        method: method,
        params: params
      }.to_json + "\r\n"
    end
  end
end

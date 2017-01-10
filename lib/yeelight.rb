require "yeelight/version"
require 'yeelight/bulb'

module Yeelight
  def self.discover
    socket  = UDPSocket.new(Socket::AF_INET)

    payload = []
    payload << "M-SEARCH * HTTP/1.1\r\n"
    payload << "HOST: 239.255.255.250:1982\r\n"
    payload << "MAN: \"ssdp:discover\"\r\n"
    payload << "ST: wifi_bulb"

    socket.send(payload.join(), 0, '239.255.255.250', 1982)

    devices = []
    begin
      Timeout.timeout(2) do
        loop do
          devices << socket.recvfrom(2048)
        end
      end
    rescue Timeout::Error => ex
      ex
    end

    ips = devices.map do |device|
      device[1][2]
    end.uniq

    ips.map do |ip|
      Yeelight::Bulb.new(ip)
    end
  end
end

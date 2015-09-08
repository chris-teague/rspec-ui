require 'ngrok/tunnel'
require 'httparty'

module RSpec
  module Ui

    class NgrokHook

      ConfigFile = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'config', 'ngrok-config-testing'))
      BrowserArmyAPIKey = '2e679057-4260-40af-a358-d55a40471f30'
      BrowserArmyURI    = 'localhost:3000'

      @@current_port = nil

      def self.update_port(port)
        return if @@current_port == port
        shutdown
        Ngrok::Tunnel.start(
          config: ConfigFile,
          port:   port
        )
        update_browser_army
        puts "PORT: #{port}"
        @@current_port = port
      end

      def self.shutdown
        Ngrok::Tunnel.stop
      end

      def self.update_browser_army
        if Ngrok::Tunnel.status == :running
          HTTParty.patch("http://#{BrowserArmyURI}/#{BrowserArmyAPIKey}.json", body: { project: { ngrok_id: ngrok_id }}).body
        else
          puts 'Not running, doh!'
        end
      end

      def self.ngrok_id
        Ngrok::Tunnel.ngrok_url.match(/http[s]?:\/\/(\w*)./)[1]
      end
    end

  end
end

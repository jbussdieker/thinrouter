#!/usr/bin/env ruby
require 'yaml'

hosts = YAML.load(File.read("config/dhcp.yaml"))

config = hosts.collect do |host|
<<-END
host #{host[:host]} {
  hardware ethernet #{host[:mac]};
  fixed-address #{host[:ip]};
}
END
end.join("\n")

puts config

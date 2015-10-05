#!/usr/bin/env ruby
require 'yaml'

config = YAML.load(File.read("config/config.yaml"))

config_raw = <<-END
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
	address #{config["address"]}
	netmask #{config["netmask"]}
	gateway #{config["gateway"]}
	dns-search #{config["domain"]}
	dns-nameservers #{config["nameservers"].join(" ")}
END

puts config_raw


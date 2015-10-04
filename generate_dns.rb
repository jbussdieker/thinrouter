#!/usr/bin/env ruby
require 'yaml'

records = YAML.load(File.read("dns.yaml"))

config = records.collect do |record|
  "#{record[:host]} IN #{record[:type].upcase} #{record[:value]}"
end.join("\n")

puts "$TTL 10800\n" + config

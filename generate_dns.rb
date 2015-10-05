#!/usr/bin/env ruby
$: << File.expand_path("./../lib", __FILE__)
require 'thinrouter'

config = ThinRouter::DNS.all.collect do |rec|
  "#{rec.host} IN #{rec.type.upcase} #{rec.value}"
end.join("\n")

puts "$TTL 10800\n" + config

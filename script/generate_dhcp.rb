#!/usr/bin/env ruby
$: << File.expand_path("./../../lib", __FILE__)
require 'thinrouter'

config = ThinRouter::DHCP.all.collect do |res|
<<-END
host #{res.host} {
  hardware ethernet #{res.mac};
  fixed-address #{res.ip};
}
END
end.join("\n")

puts config

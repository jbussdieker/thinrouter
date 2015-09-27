#!/usr/bin/env ruby
require 'strscan'

raw = File.read("/etc/dhcp/dhcpd.conf")
ss = StringScanner.new(raw)
scope = :global

data = {}

while true do
  #puts "Working (#{ss.peek(10).inspect})"

  dnsus = /^ddns\-update\-style\s+(\w+)\s?;/
  if match = ss.scan(dnsus)
    match.match(dnsus)
    data["ddns-update-style"] = $1
    p data
  end

  if ss.scan /^\s/
    puts "Skipping whitespace"
  end
end

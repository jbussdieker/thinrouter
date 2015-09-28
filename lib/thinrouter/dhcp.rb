require 'yaml'

module YamlStore
  attr_accessor :data, :filename

  def data
    @data || load_yaml
  end

  def save_yaml
    File.open(filename, 'w') do |f|
      f.puts(self.data.to_yaml)
    end
  end

  def load_yaml
    @data = YAML.load(File.read(filename))
  end
end

module Thinrouter
  class Dhcp
    extend YamlStore

    self.filename = "dhcp.yaml"

    attr_accessor :host, :mac, :ip

    def initialize(args = {})
      @args ||= args
      @host ||= args[:host]
      @mac ||= args[:mac]
      @ip ||= args[:ip]
    end

    def <=>(other)
      host <=> other.host
    end

    def to_hash
      {
        :host => @host,
        :mac => @mac,
        :ip => @ip,
      }
    end

    def dirty?
      @args[:host] != @host ||
      @args[:mac] != @mac ||
      @args[:ip] != @ip
    end

    def to_s
      host
    end

    def to_string
      host
    end

    def inspect
      host
    end

    def save
      # update class variable "data" then
      @args[:host] = @host
      @args[:mac] = @mac
      @args[:ip] = @ip
      Thinrouter::Dhcp.save_yaml
    end

    def delete
      Thinrouter::Dhcp.data.delete_if do |d|
        d[:host] == @args[:host]
      end
      Thinrouter::Dhcp.save_yaml
    end

    def self.find(id)
      all.find do |n|
        n.host == id
      end
    end

    def self.create(args = {})
      newrec = new(args)
      # Maybe check if valid
      data << args
      Thinrouter::Dhcp.save_yaml
    end

    def self.all
      data.collect do |d|
        new(d)
      end
    end
  end
end

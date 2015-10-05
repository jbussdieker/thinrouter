require 'thinrouter/yaml_store'

module ThinRouter
  class DNS
    extend YamlStore

    self.filename = "config/dns.yaml"

    attr_accessor :host, :type, :value

    def initialize(args = {})
      @args ||= args
      @host ||= args[:host]
      @type ||= args[:type]
      @value ||= args[:value]
    end

    def <=>(other)
      host <=> other.host
    end

    def to_hash
      {
        :host => @host,
        :type => @type,
        :value => @value,
      }
    end

    def dirty?
      @args[:host] != @host ||
      @args[:type] != @type ||
      @args[:value] != @value
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
      @args[:type] = @type
      @args[:value] = @value
      ThinRouter::DNS.save_yaml
    end

    def delete
      ThinRouter::DNS.data.delete_if do |d|
        d[:host] == @args[:host]
      end
      ThinRouter::DNS.save_yaml
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
      ThinRouter::DNS.save_yaml
    end

    def self.all
      data.collect do |d|
        new(d)
      end
    end
  end
end

require 'yaml'

module ThinRouter
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
end

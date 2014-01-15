require 'yaml'

module LocalPuppet
  module ENC
    def self.run(args)
      # dumb hardcode
      cwd       = File.expand_path File.dirname(__FILE__)
      dirbase   = File.dirname(File.dirname(cwd))
      node_path = "#{dirbase}/site/nodes"
      nodename  = args[0]

      nodefile = "#{node_path}/#{nodename}.yaml"
      data = Hash.new
      data = YAML.load(File.read(nodefile)) if File.exists?(nodefile)

      puts data.to_yaml
    end
  end
end

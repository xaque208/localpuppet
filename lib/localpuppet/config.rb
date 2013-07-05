require 'yaml'

module LocalPuppet
  class Config
    attr_reader :config

    def initialize
      #print "===> loading configuraiton..."

      thisdir = File.expand_path File.dirname(__FILE__)
      basedir = File.dirname(File.dirname(thisdir))

      site_config = YAML.load(File.read(basedir + '/etc/config.yaml'))

      @config = {
        :basedir        => basedir,
        :puppetfile_dir => "#{basedir}/modules",
        :puppetfile     => "#{basedir}/Puppetfile",
        :etcdir         => "#{basedir}/etc",
        :vardir         => "#{basedir}/var",
      }

      site_config.each do |k,v|
        @config[k] = v
      end
      @config
    end

    def self.config
      config = LocalPuppet::Config.new
      config.config
    end
  end
end

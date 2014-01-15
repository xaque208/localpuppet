require 'localpuppet'
require 'yaml'

# Manage the retrieval of on-disk config settings
module LocalPuppet::Config

  attr_reader :config, :basedir, :etcdir

  def self.config
    @config ||= configload()
  end

  def self.basedir
    config()[:basedir]
  end

  def self.etcdir
    config()[:etcdir]
  end

  private

  def self.configload
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
end

require 'localpuppet'
require 'localpuppet/settings'
require 'yaml'

# Manage the retrieval of on-disk config settings
module LocalPuppet::Config

  attr_reader :config, :basedir, :templatedir

  def self.config
    @config ||= configload()
  end

  def self.basedir
    config()[:basedir]
  end

  def self.templatedir
    config()[:templatedir]
  end

  private

  def self.configload

    configfile = LocalPuppet::Settings.configfile

    thisdir     = File.expand_path File.dirname(__FILE__)
    projectroot = File.dirname(File.dirname(thisdir))

    begin
      site_config = YAML.load(File.read(configfile))
    rescue => e
      puts "Unable to load config"
      puts e
      exit 1
    end

    basedir = './'

    # Set some defaults
    @config = {
      :basedir        => basedir,
      :templatedir    => "#{projectroot}/var/templates",
    }

    # Then override them from the config on disk
    site_config.each do |k,v|
      @config[k] = v
    end

    # Then expand on the results
    @config[:puppetfile_dir] = "#{@config[:basedir]}/modules"
    @config[:puppetfile]     = "#{@config[:basedir]}/puppetfile"
    @config[:vardir]         = "#{@config[:basedir]}/var"

    @config
  end
end

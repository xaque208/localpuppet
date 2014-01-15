require 'localpuppet'
require 'localpuppet/r10k'
require 'localpuppet/config'

require 'erb'
require 'fileutils'

module LocalPuppet::Setup

  def self.run
    @config = LocalPuppet::Config.config

    preflight()
    build_configs()
  end

  def self.preflight
    unless File.exists?(@config[:basedir])
      abort "===> ERR: template file missing at #{@config[:puppet_conf_erb]}"
    end

    # Create the var/ directory
    FileUtils.mkdir_p(@config[:vardir]) unless File.directory?(@config[:vardir])

    # Create the needed directories
    ['log','run','lib'].each {|d|
      dir = @config[:vardir] + '/' + d
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
    }
  end

  def self.build_configs
    yamlconfigs = []
    yamlconfigs << 'hiera'
    yamlconfigs << 'r10k'

    yamlconfigs.each do |t|
      erbfile  = @config[:basedir] + "/var/templates/#{t}.yaml.erb"
      destfile = @config[:basedir] + "/etc/#{t}.yaml"
      begin
        template  = File.read(erbfile)
        output    = ERB.new(template).result(binding)
        File.open(destfile, 'w') { |file| file.write( output ) }
      rescue => e
        raise e
      end
    end

    configs = []
    configs << 'puppet'
    configs.each do |t|
      erbfile  = @config[:basedir] + "/var/templates/#{t}.conf.erb"
      destfile = @config[:basedir] + "/etc/#{t}.conf"
      begin
        template  = File.read(erbfile)
        output    = ERB.new(template).result(binding)
        File.open(destfile, 'w') { |file| file.write( output ) }
      rescue => e
        raise e
      end
    end
  end

  def get_binding
    binding
  end
end

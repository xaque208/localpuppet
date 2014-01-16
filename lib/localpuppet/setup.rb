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

    unless File.exists?(@config[:basedir]) and File.writable?(@config[:basedir])

      begin
        FileUtils.mkdir_p(@config[:basedir])
      rescue => e
        puts "===> Unable to create base directory: #{@config[:basedir]}"
        puts e
        exit 1
      end
    end

    unless File.exists?(@config[:templatedir])
      abort "===> ERR: template directory does not exist: #{@config[:templatedir]}"
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
      erbfile  = @config[:templatedir] + "/#{t}.yaml.erb"
      destfile = @config[:basedir] + "/#{t}.yaml"
      templatize(erbfile,destfile)
    end

    configs = []
    configs << 'puppet'
    configs.each do |t|
      erbfile  = @config[:templatedir] + "/#{t}.conf.erb"
      destfile = @config[:basedir] + "/#{t}.conf"
      templatize(erbfile,destfile)
    end
  end

  private

  def self.templatize(erbfile, destfile)
      begin
        template  = File.read(erbfile)
        output    = ERB.new(template).result(binding)
        File.open(destfile, 'w') { |file| file.write( output ) }
      rescue => e
        raise e
      end
  end

  def get_binding
    binding
  end
end

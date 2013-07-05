require 'localpuppet/r10k'
require 'erb'
require 'fileutils'

module LocalPuppet
  class Setup
    def initialize(config)
      @config = config

      # Set some class variables
      @puppet_conf_erb = @config[:basedir] + '/var/templates/puppet.conf.erb'
      @puppet_conf     = @config[:basedir] + '/etc/puppet.conf'

      @r10k_conf_erb = @config[:basedir] + '/var/templates/r10k.yaml.erb'
      @r10k_conf     = @config[:basedir] + '/etc/r10k.yaml'

      @hiera_conf_erb = @config[:basedir] + '/var/templates/hiera.yaml.erb'
      @hiera_conf     = @config[:basedir] + '/hiera.yaml'

      #
      preflight()

      # Write the puppet.conf
      build_puppet_conf()

      # Write the r10k configuration file
      build_r10k_conf()

      # Write the heira configuration file
      build_hiera_conf()

      # Deploy the modules
      LocalPuppet::R10k.run(@config)

    end

    def build_puppet_conf
      confdir = @config[:basedir]

      modulepaths = @config[:modulepaths]

      begin
        template  = File.read(@puppet_conf_erb)
        output    = ERB.new(template).result(binding)

        File.open(@puppet_conf, 'w') { |file| file.write( output ) }
      rescue => e
        raise e
      end
    end

    def build_r10k_conf
      confdir         = @config[:basedir] + '/etc'
      sitename        = @config[:sitename]
      gitrepo         = @config[:gitrepo]
      cache_dir       = @config[:vardir] + '/cache/r10k'
      environment_dir = @config[:basedir] + '/environments'

      FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

      begin
        template  = File.read(@r10k_conf_erb)
        output    = ERB.new(template).result(binding)

        File.open(@r10k_conf, 'w') { |file| file.write( output ) }
      rescue => e
        raise e
      end
    end

    def build_hiera_conf
      datadir = @config[:basedir] + '/environments/%{environment}/site/data'
      begin
        template  = File.read(@hiera_conf_erb)
        output    = ERB.new(template).result(binding)

        File.open(@hiera_conf, 'w') { |file| file.write( output ) }
      rescue => e
        raise e
      end
    end

    def preflight
      unless File.exists?(@puppet_conf_erb)
        abort "===> ERR: template file missing at #{@config[:puppet_conf_erb]}"
      end

      # Create the needed directories
      log_dir = @config[:vardir] + '/log'
      run_dir = @config[:vardir] + '/run'
      lib_dir = @config[:vardir] + '/lib'

      FileUtils.mkdir_p(@config[:vardir]) unless File.directory?(@config[:vardir])
      FileUtils.mkdir_p(log_dir) unless File.directory?(log_dir)
      FileUtils.mkdir_p(run_dir) unless File.directory?(run_dir)
      FileUtils.mkdir_p(lib_dir) unless File.directory?(lib_dir)
    end

    def get_binding
      binding
    end

    def self.run(config)
      return LocalPuppet::Setup.new(config)
    end
  end
end

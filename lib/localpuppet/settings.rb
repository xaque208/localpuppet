require 'localpuppet'

# User defined command line settings
module LocalPuppet
  module Settings

    attr_accessor :verbose, :noop, :debug, :configfile, :environment, :deep

    def self.verbose
      @verbose || false
    end

    def self.verbose=(value)
      @verbose = value
    end

    def self.noop
      @noop || false
    end

    def self.noop=(value)
      @noop = value
    end

    def self.debug
      @debug || false
    end

    def self.debug=(value)
      @debug = value
    end

    def self.configfile
      @configfile || 'etc/config.yaml'
    end

    def self.configfile=(value)
      @configfile = value
    end

    def self.environment
      @environment || 'production'
    end

    def self.environment=(value)
      @environment = value
    end

    def self.deep
      if defined?(@deep)
        return @deep
      else
        return true
      end
    end

    def self.deep=(value)
      @deep = value
    end
  end
end

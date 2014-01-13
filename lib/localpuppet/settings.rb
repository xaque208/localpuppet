require 'localpuppet'

# User defined command line settings
module LocalPuppet
  module Settings

    attr_accessor :verbose, :noop, :debug

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
  end
end

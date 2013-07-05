require 'localpuppet/flags'
require 'localpuppet/runner'
require 'localpuppet/puppet'

module LocalPuppet
  class CLI

    attr_reader :flags

    def initialize(flags)
      @flags = flags
      @runner = LocalPuppet::Runner.new @flags
    end

    def sync
      @runner.sync
    end

    def setup
      @runner.setup
    end

    def nothing
      @runner.nothing
    end

    def run
      @runner.run
    end

    def self.run(*args)
      flags = LocalPuppet::Flags.new(args)
      config = flags.config

      LocalPuppet::CLI.new(config)

      case flags.cmd
      when 'sync'
        return LocalPuppet::CLI.new(config).sync
      when 'setup'
        return LocalPuppet::CLI.new(config).setup
      when 'run'
        return LocalPuppet::CLI.new(config).run
      else
        return LocalPuppet::CLI.new(config).nothing
      end
    end

  end
end

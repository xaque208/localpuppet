require 'trollop'
require 'localpuppet/config'

module LocalPuppet
  class Flags

    attr_reader :verbose
    attr_reader :config
    attr_reader :cmd

    def initialize(*args)
      @args = []

      sub_commands = %w(sync setup)

      @options = Trollop::options do
        banner          "Execute LocalPuppet commands"
        opt :verbose,   "Speak up"
        opt :noop,      "Pass noop to puppet"
        opt :debug,     "Pass debug to puppet"
        stop_on sub_commands
      end

      @verbose  = @options[:verbose] || false

      @config = LocalPuppet::Config.config
      @config[:noop] = @options[:noop] || false
      @config[:debug] = @options[:debug] || false

      @cmd = args.shift.shift.shift

    end
  end
end

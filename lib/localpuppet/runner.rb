require 'localpuppet/setup'

module LocalPuppet
  class Runner

    attr_reader :config

    def initialize(config)
      @config = config
    end

    def run
      LocalPuppet::Puppet.run(@config)
    end

    def nothing
      puts "doing nothing"
    end

    def sync
      Dir.chdir(@config[:basedir])
      %x{/usr/local/bin/git fetch origin && /usr/local/bin/git reset --hard && /usr/local/bin/git reset --hard origin/HEAD}
    end

    def setup
      LocalPuppet::Setup.run(@config)
    end

  end
end

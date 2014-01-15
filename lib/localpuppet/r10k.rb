require 'localpuppet/config'
require 'localpuppet/settings'
require 'r10k/cli'

module LocalPuppet
  module R10k
    def self.deploy

      r10k_config = LocalPuppet::Config.etcdir + '/r10k.yaml'

      unless File.exists?(r10k_config) and File.readable?(r10k_config)
        abort "===> R10k config file does not exist or is not readable.  Have you run `setup`?"
      end

      #`/usr/local/bin/r10k deploy environment -c r10k.yaml -p`
      args = []
      args << "deploy"
      args << "environment"
      args << "-c"
      args << r10k_config
      args << "-p"
      args << "-v" if LocalPuppet::Settings.verbose
      R10K::CLI.command.run(args)
    end
  end
end

require 'localpuppet/config'
require 'r10k/cli'

module LocalPuppet
  module R10k
    def self.deploy

      r10k_config = LocalPuppet::Config.etcdir + '/r10k.yaml'

      #`/usr/local/bin/r10k deploy environment -c r10k.yaml -p`
      args = []
      args << "deploy"
      args << "environment"
      args << "-c"
      args << r10k_config
      args << "-p"
      R10K::CLI.command.run(args)
    end
  end
end

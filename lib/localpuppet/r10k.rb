require 'pp'
require 'r10k/cli'

module LocalPuppet
  module R10k
    def self.run(config)
      #ENV['PUPPETFILE_DIR'] = config[:puppetfile_dir]
      #ENV['PUPPETFILE']     = config[:puppetfile]

      #`/usr/local/bin/r10k deploy environment -c #{config[:etcdir] + '/r10k.yaml'} -p`
      args = []
      args << "deploy"
      args << "environment"
      args << "-c"
      args << "#{config[:etcdir] + '/r10k.yaml'}"
      args << "-p"
      R10K::CLI.command.run(args)
    end
  end
end

module LocalPuppet
  module Puppet
    def self.run(config)

      cmd = []
      cmd << 'puppet apply -v'
      cmd << '--environment production'
      cmd << "--config #{config[:basedir] + '/etc/puppet.conf'}"
      cmd << "#{config[:basedir] + '/site/site.pp'}"
      cmd << "--noop" if config[:noop]
      cmd << "--debug" if config[:debug]

      command = cmd.join(' ')
      system(command)
    end
  end
end

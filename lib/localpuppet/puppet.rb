require 'localpuppet'
require 'localpuppet/settings'
require 'localpuppet/config'

module LocalPuppet
  module Puppet
    def self.apply

      basedir = LocalPuppet::Config.basedir

      site_pp     = basedir + '/site/site.pp'
      puppet_conf = basedir + '/etc/puppet.conf'

      cmd = []
      cmd << 'puppet apply'
      cmd << '--environment'
      cmd << LocalPuppet::Settings.environment
      cmd << '--config ' + puppet_conf
      cmd << site_pp
      cmd << '-v' if LocalPuppet::Settings.verbose
      cmd << '--noop' if LocalPuppet::Settings.noop
      cmd << '--debug' if LocalPuppet::Settings.debug

      command = cmd.join(' ')
      system(command)
    end
  end
end

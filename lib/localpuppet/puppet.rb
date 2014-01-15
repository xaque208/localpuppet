require 'localpuppet'
require 'localpuppet/settings'
require 'localpuppet/config'

module LocalPuppet
  module Puppet
    def self.apply

      verbose = LocalPuppet::Settings.verbose
      noop    = LocalPuppet::Settings.noop
      debug   = LocalPuppet::Settings.debug
      basedir = LocalPuppet::Config.basedir

      site_pp     = basedir + '/site/site.pp'
      puppet_conf = basedir + '/etc/puppet.conf'

      cmd = []
      cmd << 'puppet apply'
      cmd << '--environment production'
      cmd << '--config ' + puppet_conf
      cmd << site_pp
      cmd << '-v' if verbose
      cmd << '--noop' if noop
      cmd << '--debug' if debug

      command = cmd.join(' ')
      system(command)
    end
  end
end

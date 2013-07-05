require 'localpuppet/config'
require 'localpuppet/setup'
require 'localpuppet/puppet'

module LocalPuppet
  def self.run
    now    = Time.now()
    config = LocalPuppet::Config.config

    LocalPuppet::Puppet.run(config)
  end

  def self.setup
    now    = Time.now()
    config = LocalPuppet::Config.config

    LocalPuppet::Setup.run(config)
  end
end

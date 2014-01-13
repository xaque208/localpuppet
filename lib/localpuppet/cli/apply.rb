require 'localpuppet'
require 'localpuppet/puppet'

module LocalPuppet::CLI
  module Apply
    def self.command
      @cmd ||= Cri::Command.define do
        name    'apply'
        usage   'apply'
        summary 'Execute Puppet apply'

        description <<-DESCRIPTION
        `localpuppet apply` Execute Puppet apply with the loaded paramaters.
        DESCRIPTION

        run do |opts, args, cmd|
          LocalPuppet::Puppet.apply
        end
      end
    end
  end
  self.command.add_command(Apply.command)
end


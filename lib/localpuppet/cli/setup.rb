require 'localpuppet'
require 'localpuppet/setup'

module LocalPuppet::CLI
  module Setup
    def self.command
      @cmd ||= Cri::Command.define do
        name    'setup'
        usage   'setup'
        summary 'Prepare the localpuppet environment'

        description <<-DESCRIPTION
        `localpuppet setup` write the configs from templates and prepares the working directory.
        DESCRIPTION

        run do |opts, args, cmd|
          LocalPuppet::Setup.run
        end
      end
    end
  end
  self.command.add_command(Setup.command)
end

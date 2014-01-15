require 'localpuppet'
require 'localpuppet/sync'

module LocalPuppet::CLI
  module Sync
    def self.command
      @cmd ||= Cri::Command.define do
        name    'sync'
        usage   'sync'
        summary 'Update the working version'

        description <<-DESCRIPTION
        `localpuppet sync`
        DESCRIPTION

        run do |opts, args, cmd|
          LocalPuppet::Sync.run
        end
      end
    end
  end
  self.command.add_command(Sync.command)
end

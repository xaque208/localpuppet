require 'localpuppet'
require 'localpuppet/r10k'

module LocalPuppet::CLI
  module Deploy
    def self.command
      @cmd ||= Cri::Command.define do
        name    'deploy'
        usage   'deploy'
        summary 'Deploy the manifests with r10k'

        description <<-DESCRIPTION
        `localpuppet deploy` Execute R10k to deploy the manifests.
        DESCRIPTION

        flag :D, :nodeep, 'execute a deep deploy, default to true' do |value, cmd|
          LocalPuppet::Settings.deep = false
        end

        run do |opts, args, cmd|
          LocalPuppet::R10k.deploy
        end
      end
    end
  end
  self.command.add_command(Deploy.command)
end


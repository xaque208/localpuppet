require 'localpuppet'
require 'localpuppet/version'
require 'localpuppet/settings'

require 'cri'

module LocalPuppet::CLI
  def self.command
    @cmd ||= Cri::Command.define do
      name  'localpuppet'
      usage 'localpuppet <subcommand> [options]'
      summary 'localized puppet runs'
      description <<-EOD
        localpuppet is a tool to run puppet out of directory.  Useful for
        executing puppet apply with a given set of manifests.
      EOD

      flag :h, :help, 'show help for this command' do |value, cmd|
        puts cmd.help
        exit 0
      end

      flag :V, :version, 'show help for this command' do |value, cmd|
        puts LocalPuppet::VERSION
        exit 0
      end

      flag :v, :verbose, 'speak up' do |value, cmd|
        LocalPuppet::Settings.verbose = true
      end

      flag :n, :noop, 'run in noop' do |value, cmd|
        LocalPuppet::Settings.noop = true
      end

      flag :d, :debug, 'print debug output' do |value, cmd|
        LocalPuppet::Settings.debug = true
      end

      run do |opts, args, cmd|
        puts cmd.help(:verbose => opts[:verbose])
        exit 0
      end
    end
  end
end

require 'localpuppet/cli/setup'
require 'localpuppet/cli/sync'
require 'localpuppet/cli/apply'
require 'localpuppet/cli/deploy'

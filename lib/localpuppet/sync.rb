require 'localpuppet'

module LocalPuppet::Sync
  def self.run
    basedir = LocalPuppet::Config.basedir
    Dir.chdir(basedir)
    puts "Would sync here"
    #%x{/usr/local/bin/git fetch origin && /usr/local/bin/git reset --hard && /usr/local/bin/git reset --hard origin/HEAD}
  end
end

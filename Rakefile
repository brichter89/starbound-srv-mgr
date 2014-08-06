require 'bundler/gem_tasks'
require 'StarboundSrvMgr/version'

version = StarboundSrvMgr::VERSION

if ARGV.include?('release') && version =~ /dev|pre|-/i
    $stderr.puts 'rake aborted!'
    $stderr.puts %q{Version string may not contain 'dev', 'pre' or '-' when releasing!}
    $stderr.puts "Provided version: #{version}"
    abort
end

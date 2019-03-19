#!/usr/bin/env ruby

require 'pathname'
require 'logger'

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO
ROOT = Rake.original_dir

def shell_execute(command, chdir = Dir.pwd)
  LOG.info "Running `#{command}` in directory #{chdir}"
  pid = Process.fork do
    Dir.chdir(chdir) do
      exec command
    end
  end
  Process.wait pid
  ret = $?
  ret
end

def shell(command, chdir = Dir.pwd)
  ret = shell_execute command, chdir
  exit(ret.exitstatus) unless ret.success?
end

dir = Pathname.new('./site').expand_path
modules = Dir.entries(dir).select {|entry| File.directory? File.join(dir,entry) and !(entry =='.' || entry == '..') }

namespace :test do
  desc 'Prepares tests environment'
  task :prepare do
    modules.each do |mod|
      sub = dir.join(mod)
      gemfile = sub.join('Gemfile')
      gemfile_lock = sub.join('Gemfile.lock')
      LOG.info "Using Gemfile: #{gemfile}"
      ENV['BUNDLE_GEMFILE'] = gemfile.to_s
      File.delete gemfile_lock if File.file? gemfile_lock
      shell 'bundle install', sub if File.file? gemfile
    end
  end

  desc 'Runs rspec tests for all puppet modules'
  task :execute do
    modules.each do |mod|
      sub = dir.join(mod)
      rakefile = sub.join('Rakefile')
      LOG.info "Using Rakefile: #{rakefile}"
      shell 'bundle exec rake test', sub if File.file? rakefile
    end
  end
end

task :'test' => [
  :'test:prepare',
  :'test:execute'
]

task :default => [
  :test
]

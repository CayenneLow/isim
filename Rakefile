require 'rubygems'
require 'rake'
require 'rake/clean'

task :default => :build

desc 'Build isim'
task :build  do |t|
  sh %Q[xcodebuild clean build]
end

desc 'Install idb on the system'
task :install => 'build' do |t|
  sh %Q[/bin/cp -f "build/Release/isim" /usr/local/bin/]
end

desc 'Clean'
task :clean do |t|
  sh %Q[xcodebuild clean]
end

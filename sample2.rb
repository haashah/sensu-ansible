#!/usr/bin/env ruby

# simple ruby script to extract PowerDNS recursor statistics and dump them in a text file


system "sudo rec_control get-all tmp.txt"

if $?.exitstatus > 0
  puts "failed to dump pdns statistics. check pdns process is running!"
  exit 2
end

File.readlines('tmp.txt').each do |line|
  puts line
end

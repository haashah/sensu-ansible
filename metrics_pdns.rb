#!/usr/bin/env ruby

# simple ruby script to extract PowerDNS recursor statistics and send them in Graphite PlainText format 


def output(*args)
  unless args.empty?
    if args[2].nil?
      args[2] = Time.now.to_i
    end
    puts " Hello SafeDNS-US-#{`hostname -f`.chomp}-- #{args[0..2].join("\s")}"
  end
end
   
# dump powerdns statistics using rec control
system "sudo rec_control get-all > tmp.txt"

if $?.exitstatus > 0
  puts "failed to dump pdns statistics. check pdns process is running!"
  exit 2
end

File.readlines('tmp.txt').each do |line|
  output line.split()[0], line.split()[1]
end

# time to cleanup dump file
system "sudo rm -rf tmp.txt"

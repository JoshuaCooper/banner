require 'sys/filesystem'
include Sys

def diskAvail (current_disk)
	#unused	
end

def diskSize (current_disk)
	disk_stats = Filesystem.stat(current_disk)
	return disk_stats.bytes_free / 1024 / 1024 / 1024
end

def listDisks ()
	#list the current mounted volumes excluding v
	diskList = `df | grep -vE '^Filesystem|tmpfs|cdrom|rootfs|udev|boot' | awk '{print $6}'`
end

c = listDisks.lines
mounts = Hash.new

c.each { |thing| mounts[thing] = diskSize(thing.gsub(/\n/, "")) }
#!/usr/bin/perl
################################################################################
# queryDisks.pl - Generate a list of disk devices and return in JSON format
################################################################################
#
# This script reads /proc/diskstats and returns a list of devices it finds
# in JSON format:
#
#	{#DISK} = "<device_name>"
#
# It is intended to use with the Zabbix Agent to enable low-level discovery
# for disk devices in Zabbix. 
#
################################################################################
use strict;
use warnings;

# Options
my $_proc = "/proc/diskstats";

# Validate options
if ( ! -e $_proc)
{
	die "File $_proc not found!";
}

# Keep count
my $_first = 1;

# Present the data in JSON format
print "{\n";
print "\t\"data\":[\n\n";

# Fetch the data and put it in an array
my @_data = `cat $_proc | awk '{ print \$3 }'`;
chomp @_data;

# Read the array and print the wanted data
foreach my $_disk (@_data)
{
	# Print the data in JSON	
	print "\t,\n" if not $_first;
	$_first = 0;

	print "\t{\n";
	print "\t\t\"{#DISK}\":\"$_disk\"\n";
	print "\n\t}\n";
}

print "\n\t]\n";
print "}\n";

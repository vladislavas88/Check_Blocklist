#!/usr/bin/env perl 

=pod

=head1 Check modify time of squid ACL (blocklist) and reload squid   
#===============================================================================
#
#         FILE: check_blocklist.pl
#
#        USAGE: Add ./check_blocklist.pl in /etc/crontab
#           	*/10    *       *       *       *       root    /home/admin/check_blocklist.pl
#
#  DESCRIPTION: Check modify time of squid ACL (blocklist) and reload squid
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Vladislav Sapunov
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 09.09.2024 23:38:14
#     REVISION: ---
#===============================================================================
=cut

use strict;
use warnings;
use v5.14;
use utf8;
use File::stat;

my $usrBlockList   = "/home/admin/blocklist";
my $oldModTimeFile = "/home/admin/oldModTime";
my $curModTime     = ( stat($usrBlockList)->mtime );

#say "$curModTime";
open( FHR, '<', $oldModTimeFile ) or die "Couldn't Open file $oldModTimeFile" . "$!\n";
my $oldModTime = <FHR>;
close(FHR) or die "$!\n";

#say "$oldModTime";
if ( $curModTime > $oldModTime ) {
    #system("service squid reload");
    open( FHW, '>', $oldModTimeFile ) or die "Couldn't Open file $oldModTimeFile" . "$!\n";
    print FHW $curModTime;
    close(FHW) or die "$!\n";
} else {
    die;
}


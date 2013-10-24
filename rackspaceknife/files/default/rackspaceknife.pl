#!/usr/bin/perl

###############################################################################
# The primary purpose of rackspaceknife.pl is to provide a Perl cmd-line      #
# utility to Rackspace's API using the CPAN module WebService::Rackspace.     #
# As of right now, rackspaceknife.pl only supports Rackspace Cloud files      #
# using the CPAN module WebService::Rackspace::CloudFiles.                    #
#################$Author: Gerald L. Hevener, Jr., M.S. $#######################
#                        $Date: June 30, 2011 $                               #
#                            $Revision: #1 $                                  #
#                   $Id: /usr/local/bin/rackspaceknife.pl $                   #
#                 $HeadURL: /usr/local/bin/rackspaceknife.pl $                #
#                   $Source: /usr/local/bin/ldapknife.pl $                    #
#        (C) 2011 : Gerald L. Hevener Jr., M.S. All Rights Reserved           #
#        (C) 2011 : jackl0phty.org All Rights Reserved                        #
#       Licensed under the Apache License, Version 2.0 (the "License"),       #
# For any questions regarding the license of this software, please refer to   #
# the actual license at http://www.apache.org/licenses/LICENSE-2.0.txt.       #
###############################################################################
#                        DISCLAIMER OF WARRENTY                               #
# BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR  #
# THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN        #
# OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES      #
# PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED #
# OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF        #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO #
# THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH YOU. SHOULD THE         #
# SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,   #
# REPAIR, OR CORRECTION. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR     #
# AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY  #
# MODIFY AND/OR REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE,  #
# BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,   #
# OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE     #
# SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED  #
# INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIESOR A FAILURE OF THE   #
# SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF SUCH HOLDER OR OTHER  #
# PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.                  #
###############################################################################
################# USE THIS SOFTWARE AT YOUR OWN RISK!!!!#######################
###############################################################################

# Let's be strict and warn
use strict;
use warnings;

# Import required modules
use Getopt::Declare;
use Carp;
use version;
use IPC::Run qw ( run timeout );
use WebService::Rackspace::CloudFiles;

# ldapknife.pl VERSION
our $VERSION = qv(1.0.2);

# Declare variables
my $username;
my $apikey;
my $ncontainer;
my $tbytes;
my $container;
my $objcount;

# Specify the usage specification for the program
my $specification = <<'USAGE_SPEC';
  --user	Username for manage.rackspacecloud.com
  --key		API key from manage.rackspacecloud.com
  --help   	Print USAGE page
		  		{ $self->usage(0) }
  -help		[ditto]
  --list	List all containers for Rackspace Cloud Files
		   	{ list_all_containers() } 
  --ncontainer	Create a new container
  			{ create_new_container() }
  --tbytes	Get total bytes used for Rackspace Cloud Files
			{ get_total_bytes() }
  --objcount	Get object count of given container
   		( e.g. # of files in a container )
  			{ get_object_count() }
  --		End of argument list
  			{ finish }
USAGE_SPEC

# Automatically generate help, usage, & version information
# See specification above for details
my $args = Getopt::Declare->new($specification);

# If number of options < 1 print USAGE
if ( $#ARGV < 1 ) {

    print $args->usage() or croak 'Couldn\'t print tool usage';

}

##################MAIN PROGRAM LOGIC######################


##################MAIN PROGRAM LOGIC######################

sub get_cmd_line_options {

    # Get cmd line options
    foreach my $option ( 0 .. $#ARGV ) {

        # Get --user option
        if ( $ARGV[$option] =~ m/--user/gmx ) {

            $username = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$username = $username\n";

        }

		# Get --key option
        if ( $ARGV[$option] =~ m/--key/gmx ) {

            $apikey = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$apikey = $apikey\n";

        }

	    # Get --ncontainer option
        if ( $ARGV[$option] =~ m/--ncontainer/gmx ) {

            $ncontainer = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$ncontainer = $ncontainer\n";

        }
 
 	   # Get --tbytes option
        if ( $ARGV[$option] =~ m/--tbytes/gmx ) {

	        #$container = $ARGV[ $option + 1 ];
			$tbytes = $tbytes;

            # Uncomment next line to debug
            #print "\$container = $container\n";

        }
 
        # Get --objcount option
        if ( $ARGV[$option] =~ m/--objcount/gmx ) {

            $container = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$container = $container\n";

        }

		

        # End foreach loop
    }	

    # End sub with a return
    return;

    # End sub get_cmd_line_options
}

sub list_all_containers {

	# Declare local variables

	# Get command line options
	get_cmd_line_options();

	#Uncomment to debug
	#print "\$username = $username\n";
    #print "\$apikey = $apikey\n";

	# Build CloudFiles object with user and key
	my $cloudfiles = WebService::Rackspace::CloudFiles->new(
      user => "$username",
      key  => "$apikey",
  	);

	# List all containers of Rackspace Cloud files
    my @containers = $cloudfiles->containers;

	foreach my $container (@containers) {
 		print $container->name;
		print "\n";
  	}

	# End sub with a return
    return;

    # End sub list_all_containers

}	

sub create_new_container {

	# Get command line options
	get_cmd_line_options();

	# Build CloudFiles object with user and key
    my $cloudfiles = WebService::Rackspace::CloudFiles->new(
  	  user => "$username",
      key  => "$apikey",
    );

	#Uncomment to debug
	#print "\$username = $username\n";
	#print "\$apikey = $apikey\n";
    #print "\$ncontainer = $ncontainer\n";

	# Create a new container
    my $container = $cloudfiles->create_container(name => "$ncontainer");   
	
	# End sub with a return
    return;

    # End sub create_new_container

}

sub get_total_bytes {

   # Get command line options
    get_cmd_line_options();

    # Build CloudFiles object with user and key
    my $cloudfiles = WebService::Rackspace::CloudFiles->new(
      user => "$username",
      key  => "$apikey",
    );

 	# Get total bytes used
    $tbytes = $cloudfiles->total_bytes_used;

    # Uncomment to debug
    #print "\$username = $username\n";
    #print "\$apikey = $apikey\n";
    #print "\$tbytes = $bytes\n";

	# Print total bytes used
	print "$tbytes\n";

    # End sub with a return
    return;

    # End sub get_total_bytes

}

sub get_object_count {

    # Get command line options
    get_cmd_line_options();

    # Build CloudFiles object with user and key
    my $cloudfiles = WebService::Rackspace::CloudFiles->new(
      user => "$username",
      key  => "$apikey",
    );
 
	# Get existing container
	my $container = $cloudfiles->container(name => "$container");

    # Get object count
	$objcount = $container->object_count;

    # Uncomment to debug
    #print "\$username = $username\n";
    #print "\$apikey = $apikey\n";
    #print "\$objcount = $objcount\n";
 
	# Print object count
	print "$objcount\n";

}

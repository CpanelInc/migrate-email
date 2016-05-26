#!/usr/bin/perl

use strict;
use warnings;

# This is a simple test script hardcoded for our gmail test account used during the WHD.usa
# Hackathon 2016. It is expect to be thrown away at some point

use lib '/usr/local/migrate-email';

use MigrateMail ();

my ( $locpass, $rempass ) = @ARGV;

MigrateMail::setupmigrateuser( 'remoteuser' => 'cpanel.email.migrate@gmail.com', 'remotepass' => $rempass, 'remoteserver' => 'imap.gmail.com', 'localuser' => 'cemtest@cem.test', 'localpass' => $locpass, 'localserver' => '127.0.0.1' );

MigrateMail::domigrateuser();


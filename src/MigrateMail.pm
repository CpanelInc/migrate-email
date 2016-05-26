package Cpanel::API::MigrateMail;

# copyright 2017 cPanel, Inc
# Licensed under the terms of the Apache 2.0 license

use strict;
use warnings;

our $VERSION = '0.1';

use Cpanel::FindBin         ();
use Cpanel::SafeRun::Simple ();

sub domigrateuser {

    my ( $args, $result ) = @_;

    my ( $remoteuser, $remotepass, $localuser, $localpass ) = $args->get( 'remoteEmail', 'remotePassword', 'localEmail', 'localPassword' );

    my $remoteserver = 'imap.gmail.com';
    my $localserver  = 'localhost';

    my $imapsync = Cpanel::FindBin::findbin('imapsync');

    my $localport  = '993';
    my $remoteport = '993';

    my @defaultoptions = ( '--automap', '--syncinternaldates', '--ssl1', '--ssl2', '--noauthmd5', '--exclude', 'All Mail|Spam|Trash', '--allowsizemismatch', '--logdir', '/tmp', '--logfile', 'imapsync.txt' );

    my @mailoptions = ( '--host1', $remoteserver, '--user1', $remoteuser, '--password1', $remotepass, '--host2', $localserver, '--user2', $localuser, '--password2', $localpass, '--port1', $remoteport, '--port2', $localport );

    my @largemailboxopts = ('--split1 100 --split2 100');

    Cpanel::SafeRun::Simple::saferun( $imapsync, @mailoptions, @defaultoptions );

}

sub services {
    my ( $args, $result ) = @_;

    my @results;
    $result->data(
        [
            {
                'name'   => 'Gmail',
                'server' => 'imap.gmail.com'
            }
        ]
    );

    return 1;
}

1;

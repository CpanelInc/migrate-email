package MigrateMail;

use strict;
use warnings;

our $VERSION = '0.1';

use Cpanel::FindBin             ();
use Cpanel::SafeRun::Simple     ();

my ($remoteuser, $remotepass, $remoteserver, $localuser, $localpass, $localserver, $usessl, $mailservice);

sub setupmigrateuser {

    # Will need to check for defaults already set, plus set default or die if nothing given

    my %OPTS            = @_;
    $remoteuser      = $OPTS{'remoteuser'};
    $remotepass      = $OPTS{'remotepass'};
    $remoteserver    = $OPTS{'remoteserver'};
    $localuser       = $OPTS{'localuser'};
    $localpass       = $OPTS{'localpass'};
    $localserver     = $OPTS{'localserver'};
    $usessl          = $OPTS{'usessl'};
    $mailservice     = $OPTS{'mailservice'};

}

sub domigrateuser {

   my $imapsync = Cpanel::FindBin::findbin('imapsync');

   my $localport  = '993';
   my $remoteport = '993';

   my @defaultoptions = ('--automap', '--syncinternaldates', '--ssl1', '--ssl2', '--noauthmd5', '--exclude', 'All Mail|Spam|Trash', '--allowsizemismatch');

   my @mailoptions = ('--host1', $remoteserver, '--user1', $remoteuser, '--password1', $remotepass, '--host2', $localserver, '--user2', $localuser, '--password2', $localpass, '--port1', $remoteport, '--port2', $localport);

   my @largemailboxopts = ('--split1 100 --split2 100');

   Cpanel::SafeRun::Simple::saferun( $imapsync, @mailoptions, @defaultoptions);

}
1;


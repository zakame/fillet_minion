package FilletMinion::Job::SendLoad;
use Mojo::Base -strict;

sub new {
  sub {
    my ( $job, $params ) = @_;
    sleep 5;
    $job->app->log->info( 'phone number:', $params->{phone_number} );
    $job->app->log->info( 'amount:',       $params->{amount} );
    }
}

1;

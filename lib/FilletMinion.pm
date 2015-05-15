package FilletMinion;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Minion job queue
  $self->plugin( Minion => { File => $self->home->rel_file('fm.db') } );
  $self->minion->add_task(
    send_load => sub {
      my ( $job, $params ) = @_;
      sleep 5;
      $job->app->log->debug('send load process worker');
      $job->app->log->debug( 'phone number:', $params->{phone_number} );
      $job->app->log->debug( 'amount:',       $params->{amount} );
    }
  );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');

  # Send Load route
  $r->get('/load')->to('load#index');
  $r->post('/load')->to('load#post_load_request');
}

1;

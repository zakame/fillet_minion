package FilletMinion;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # fix up log format
  $self->app->log->format(
    sub {
      my ( $log, $level, @lines ) = @_;
      '[' . localtime($log) . '] [' . $level . '] ' . join " ", @lines, "\n";
    }
  );

  # Minion job queue
  $self->plugin( Minion => { File => $self->home->rel_file('fm.db') } );
  $self->minion->add_task(
    send_load => sub {
      my ( $job, $params ) = @_;
      sleep 5;
      $job->app->log->info( 'phone number:', $params->{phone_number} );
      $job->app->log->info( 'amount:',       $params->{amount} );
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

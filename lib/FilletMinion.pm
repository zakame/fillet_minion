package FilletMinion;
use Mojo::Base 'Mojolicious';
use FilletMinion::Job::SendLoad;

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
  $self->minion->add_task( send_load => FilletMinion::Job::SendLoad->new );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');

  # Send Load route
  $r->get('/load')->to('load#index');
  $r->post('/load')->to('load#post_load_request');
}

1;

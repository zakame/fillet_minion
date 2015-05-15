package FilletMinion;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Minion job queue
  $self->plugin( Minion => { File => $self->home->rel_file('fm.db') } );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');

  # Send Load route
  $r->get('/load')->to('load#index');
  $r->post('/load')->to('load#post_load_request');
}

1;

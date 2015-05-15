package FilletMinion::Controller::Load;
use Mojo::Base 'Mojolicious::Controller';

sub index { shift->render }

sub post_load_request {
  my $self = shift;

  $self->redirect_to('index') unless $self->req->body_params;

  $self->render( text => 'load request pending' );
}

1;

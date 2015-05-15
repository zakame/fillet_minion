package FilletMinion::Controller::Load;
use Mojo::Base 'Mojolicious::Controller';

sub index { shift->render }

sub post_load_request {
  my $self = shift;
  my $params = $self->req->body_params->to_hash;

  return $self->redirect_to('index') unless %$params;

  $self->minion->enqueue( send_load => [$params] );

  $self->render( text => 'load request pending' );
}

1;

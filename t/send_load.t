use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('FilletMinion');

## send load form
$t->get_ok('/load')->status_is(200)->content_like(qr/Send Load/i)
  ->content_like(qr/Phone Number/i)->content_like(qr/Amount/i);

## form processor

# redirect to the main form if nothing is in the POST
$t->post_ok('/load')->status_is(302);

# send some load to my phone!
$t->post_ok( '/load' => form =>
    { phone_number => '09083594005', amount => int rand 500 } )
  ->status_is(200)->content_like(qr/load request pending/i);

done_testing();

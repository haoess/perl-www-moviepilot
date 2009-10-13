package WWW::Moviepilot::Movie;

use warnings;
use strict;

use Carp;
use JSON::Any;

=head1 NAME

WWW::Moviepilot::Movie - Handle moviepilot.de movies.

=head1 SYNOPSIS

    my $movie = WWW::Moviepilot->new->movie( 'matrix' );

    # all fields
    my @fields = $movie->fields;

    # direct access to fields
    print $movie->display_title; # "Matrix"
    print $movie->title;         # field does not exist => undef

    # *_lists in scalar context
    print scalar $movie->emotions_list; # "Spannend,Aufregend"

    # *_lists in list context
    print join ' +++ ', $movie->emotions_list # "Spannend +++ Aufregend"


=head1 METHODS

=head2 new

Creates a blank WWW::Moviepilot::Movie object.

    my $movie = WWW::Moviepilot::Movie->new;

=cut

sub new {
    my ($class, $args) = @_;
    my $self = bless {} => $class;
    return $self;
}

=head2 populate( $args )

Populates an object with data, you should not use this directly.

=cut

sub populate {
    my ($self, $args) = @_;
    $self->{data} = $args->{data};
}

=head2 poster

=cut

sub poster {
    my $self = shift;
}

=head2 fields

Returns a list with all fields for this movie.

    my @fields = $movie->fields;

    # print all fields
    foreach my $field ( @fields ) {
        printf "%s: %s\n", $field. $movie->$field;
    }

As of 2009-10-13, these fields are supported:

=over 4

=item * alternative_identifiers

=item * average_community_rating

=item * average_critics_rating

=item * cinema_start_date

=item * countries_list

=item * display_title

=item * dvd_start_date

=item * emotions_list

=item * genres_list

=item * homepage

=item * long_description

=item * on_tv

=item * places_list

=item * plots_list

=item * poster

=item * premiere_date

=item * production_year

=item * restful_url

=item * runtime

=item * short_description

=item * times_list

=back

=cut

sub fields {
    my $self = shift;
    return keys %{ $self->{data} };
}

our $AUTOLOAD;
sub AUTOLOAD {
    my $self = shift;
    my $field = $AUTOLOAD;
    $field =~ s/.*://;
    if ( !exists $self->{data}{$field} ) {
        return;
    }

    if ( $field =~ /_list$/ && wantarray ) {
        return split /,/, $self->{data}{$field};
    }

    return $self->{data}{$field};
}

1;
__END__

=head1 AUTHOR

Frank Wiegand, C<< <frank.wiegand at gmail.com> >>

=head1 SEE ALSO

L<WWW::Moviepilot>.

=head1 COPYRIGHT & LICENSE

Copyright 2009 Frank Wiegand.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

package Teng::Plugin::TmpSuppressRowObjects;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

our @EXPORT;

BEGIN {
    @EXPORT = qw(
        search_by_sql_hashref
    );
    no strict 'refs';
    for my $method (@EXPORT) {
        (my $orig = $method) =~ s/_hashref$//;
        *{__PACKAGE__ . '::' . $method} = sub {
            my $self = shift;
            local $self->{suppress_row_objects} = 1;
            $self->$orig(@_);
        };
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Teng::Plugin::TmpSuppressRowObjects - It's new $module

=head1 SYNOPSIS

    use Teng::Plugin::TmpSuppressRowObjects;

=head1 DESCRIPTION

Teng::Plugin::TmpSuppressRowObjects is ...

=head1 LICENSE

Copyright (C) egawata.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

egawata E<lt>egawa.takashi@gmail.comE<gt>

=cut


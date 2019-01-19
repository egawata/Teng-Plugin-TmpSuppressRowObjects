# NAME

Teng::Plugin::TmpSuppressRowObjects - add methods with temporary use of suppress\_row\_objects

# SYNOPSIS

    use Teng::Plugin::TmpSuppressRowObjects;

    #  In case suppress_row_objects = 0 ...
    my $teng = Teng->new(dbh => $dbh, suppress_row_objects => 0);
    my $row;

    #  same usage with original 'search'
    $row = $teng->search_hashref(test_table => +{ id => 100 });     #  $row is hashref

    #  does not affect original 'search'
    $row = $teng->search(test_table => +{ id => 100 });     #  $row is row object

# DESCRIPTION

This plugin adds some methods, which suppress generating row objects, even when `suppress_row_objects` is 0.
It is helpful when we want to use row objects in default, but temporarily use hashref to improve performance.

# METHODS

    insert_hashref
    search_hashref
    single_hashref
    search_by_sql_hashref
    single_by_sql_hashref
    search_named_hashref
    single_named_hashref

Usage of those methods are the same to original methods (without `_hashref`).

# LICENSE

Copyright (C) egawata.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

egawata <egawa.takashi@gmail.com>

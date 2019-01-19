use strict;
use warnings;
use utf8;

use lib qw(. lib t/lib);

use t::Util;
use Test::More;

my $db = create_testdb();

subtest 'search_by_sql_hashref' => sub {
    my ($row) = $db->search_by_sql_hashref(q{
        SELECT * FROM test_table
    });
    is ref $row, 'HASH';
    is_deeply $row, { id => 1, name => 'Apple' };
};

subtest 'does not affect original method' => sub {
    my ($row) = $db->search_by_sql(q{
        SELECT * FROM test_table
    });
    is ref $row, 'TestDB::Model::Row::TestTable';
    is_deeply $row->get_columns, { id => 1, name => 'Apple' };
};

done_testing;

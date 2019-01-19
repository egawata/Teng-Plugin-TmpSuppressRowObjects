use strict;
use warnings;
use utf8;

use lib qw(lib t/lib .);

use t::Util;
use Test::More;

my $db = create_testdb();
$db->dbh->do(q{
    INSERT INTO test_table (id, name) VALUES (1, 'Apple'), (2, 'Banana'), (3, 'Coconut')
});

subtest 'search_by_sql_hashref' => sub {
    my @rows = $db->search_by_sql_hashref(q{
        SELECT * FROM test_table WHERE id IN (?, ?) ORDER BY id
    }, [2, 3], 'test_table');
    is ref $rows[0], 'HASH';
    is_deeply \@rows, [
        { id => 2, name => 'Banana' },
        { id => 3, name => 'Coconut' },
    ];
};

subtest 'does not affect original method' => sub {
    my @rows = $db->search_by_sql(q{
        SELECT * FROM test_table WHERE id IN (?, ?) ORDER BY id
    }, [2, 3], 'test_table');
    is ref $rows[0], 'TestDB::Model::Row::TestTable';
    is_deeply [ map { $_->get_columns } @rows ], [
        { id => 2, name => 'Banana' },
        { id => 3, name => 'Coconut' },
    ];
};

done_testing;

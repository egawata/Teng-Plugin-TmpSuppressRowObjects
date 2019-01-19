use strict;
use warnings;
use utf8;

use lib qw(lib t/lib);

use Test::More;
use DBI;
use TestDB::Model;

my $dbh = DBI->connect('dbi:SQLite::memory:','','',{RaiseError => 1, PrintError => 0, AutoCommit => 1});
my $db = TestDB::Model->new(dbh => $dbh, suppress_row_objects => 0);

$dbh->do(q{
    CREATE TABLE test_table (
        id integer not null,
        name varchar(255),
        primary key (id)
    )
});
$dbh->do(q{
    INSERT INTO test_table (id, name) VALUES (1, 'Apple')
});

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

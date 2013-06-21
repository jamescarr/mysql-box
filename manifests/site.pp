node default {
  include mysql
  
  # install mysql-server, setting the root password and the bind address
  class { 'mysql::server':
    config_hash       => { 
      'root_password' => 'foo',

      # we bind to 0.0.0.0 so we can connect from the host machine
      'bind_address'  => '0.0.0.0',
    }
  }

  # let's setup a database with some data seeded in it.
  mysql::db { 'testdb':
    user     => 'bob',
    password => 'cleverpassword',
    host     => '%',
    grant    => ['all'],
    sql      => '/vagrant/loaddata.sql',
    require  => Class['mysql::server'],
  }

}

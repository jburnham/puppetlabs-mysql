#
class mysql::server::root_password {

  $options = $mysql::globals::options

  # manage root password if it is set
  if $mysql::server::root_password != 'UNSET' {
    mysql_user { 'root@localhost':
      ensure        => present,
      password_hash => mysql_password($mysql::server::root_password),
    }

    file { "${::root_home}/.my.cnf":
      content => template('mysql/my.cnf.pass.erb'),
      require => Mysql_user['root@localhost'],
    }
  }

}

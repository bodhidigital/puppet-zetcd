# command/go_package.pp

class zetcd::command::go_package (
  Boolean $manage_go_package  = $::zetcd::manage_go_package,
  String  $go_package         = $::zetcd::go_package,
) {
  if $manage_go_package {
    package { 'go':
      name    => $go_package,
      ensure  => present,
    }
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

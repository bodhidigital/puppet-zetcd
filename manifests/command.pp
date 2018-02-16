# command.pp

class zetcd::command (
  Boolean               $manage_command     = $::zetcd::manage_command,
  Stdlib::Absolutepath  $gopath_cache       = '/var/cache/zetcd-go',
) {
  if $manage_command {
    contain '::zetcd::command::go_package'
    contain '::zetcd::command::build'
    contain '::zetcd::command::install'
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

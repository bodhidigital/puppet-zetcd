# command/install.pp

class zetcd::command::install (
  Stdlib::Absolutepath  $zetcd_path   = $::zetcd::zetcd_path,
  Stdlib::Absolutepath  $gopath_cache = $::zetcd::command::gopath_cache,
) {
  require '::zetcd::command::build'

  file { 'bin/zetcd':
    path    => "$zetcd_path",
    source  => "$gopath_cache/bin/zetcd",
    mode    => '0755',
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

# command/build.pp

class zetcd::command::build (
  String                $zetcd_source = $::zetcd::zetcd_source,
  Stdlib::Absolutepath  $go_path      = $::zetcd::go_path,
  Stdlib::Absolutepath  $gopath_cache = $::zetcd::command::gopath_cache,
) {
  require '::zetcd::command::go_package'

  exec { 'go get zetcd':
    command     => join([$go_path, 'get', $zetcd_source], ' '),
    creates     => "$gopath_cache/bin/zetcd",
    environment => [ "GOPATH=$gopath_cache" ],
    timeout     => 600,
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

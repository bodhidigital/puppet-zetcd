# params.pp

class zetcd::params {
  $manage_command       = true
  $manage_go_package    = true
  $manage_service_file  = true
  $manage_service       = true
  $manage_zetcd_user    = true
  $manage_zetcd_group   = true

  $zetcd_source = 'github.com/coreos/zetcd/cmd/zetcd'
  $zetcd_path   = '/usr/local/bin/zetcd'

  case $::facts['os']['family'] {
    'Debian': {
      $go_package = 'golang-1.8-go'
      $go_path    = '/usr/lib/go-1.8/bin/go'
    }
  }

  $service_name = 'zetcd'

  $zetcd_user   = 'zetcd'
  $zetcd_group  = 'zetcd'

  $zkaddr     = '127.0.0.1:2181'
  $endpoints  = [ 'http://localhost:2379' ]
  $cafile     = undef
  $certfile   = undef
  $keyfile    = undef
}

# vim: set ts=2 sw=2 et syn=puppet:

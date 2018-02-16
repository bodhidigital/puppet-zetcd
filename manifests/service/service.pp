# service/service.pp

class zetcd::service::service (
  Boolean $manage_service = $::zetcd::manage_service,
  String  $service_name   = $::zetcd::service_name,
) {
  require '::zetcd::conf'

  if $manage_service {
    service { 'zetcd':
      name      => $service_name,
      ensure    => running,
      enable    => true,
      subscribe => Class['::zetcd::conf'],
    }
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

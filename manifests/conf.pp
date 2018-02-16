# conf.pp

class zetcd::conf (
  String  $service_name = $::zetcd::service_name,
) {
  file { '/etc/default/zetcd':
    path    => "/etc/default/$service_name",
    content => epp("$module_name/zetcd.conf.epp")
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

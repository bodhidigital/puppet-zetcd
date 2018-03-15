# service/file.pp

class zetcd::service::file (
  Boolean $manage_service_file  = $::zetcd::params::manage_service_file,
  String  $service_name         = $::zetcd::params::service_name,
) {
  require '::zetcd::command'

  exec { 'reload systemd for zetcd':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }

  if $manage_service_file {
    file { 'zetcd.service':
      path    => "/etc/systemd/system/$service_name.service",
      content => epp("$module_name/zetcd.service.epp"),
      notify  => Exec['reload systemd for zetcd'],
    }
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

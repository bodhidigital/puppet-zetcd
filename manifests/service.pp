# service.pp

class zetcd::service {
  contain '::zetcd::service::file'
  contain '::zetcd::service::service'
}

# vim: set ts=2 sw=2 et syn=puppet:

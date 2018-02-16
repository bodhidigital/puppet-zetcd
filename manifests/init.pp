# init.pp

class zetcd (
  Boolean                         $manage_command       = $::zetcd::params::manage_command,
  Boolean                         $manage_go_package    = $::zetcd::params::manage_go_package,
  Boolean                         $manage_service_file  = $::zetcd::params::manage_service_file,
  Boolean                         $manage_service       = $::zetcd::params::manage_service,
  Boolean                         $manage_zetcd_user    = $::zetcd::params::manage_zetcd_user,
  Boolean                         $manage_zetcd_group   = $::zetcd::params::manage_zetcd_group,
  String                          $zetcd_source         = $::zetcd::params::zetcd_source,
  Stdlib::Absolutepath            $zetcd_path           = $::zetcd::params::zetcd_path,
  String                          $go_package           = $::zetcd::params::go_package,
  Stdlib::Absolutepath            $go_path              = $::zetcd::params::go_path,
  String                          $service_name         = $::zetcd::params::service_name,
  String                          $zetcd_user           = $::zetcd::params::zetcd_user,
  String                          $zetcd_group          = $::zetcd::params::zetcd_group,
  String                          $zkaddr               = $::zetcd::params::zkaddr,
  Array[Stdlib::Httpurl]          $endpoints            = $::zetcd::params::endpoints,
  Optional[Stdlib::Absolutepath]  $cafile               = $::zetcd::params::cafile,
  Optional[Stdlib::Absolutepath]  $certfile             = $::zetcd::params::certfile,
  Optional[Stdlib::Absolutepath]  $keyfile              = $::zetcd::params::keyfile,
) inherits ::zetcd::params {
  contain '::zetcd::user'
  contain '::zetcd::command'
  contain '::zetcd::conf'
  contain '::zetcd::service'
}

# vim: set ts=2 sw=2 et syn=puppet:

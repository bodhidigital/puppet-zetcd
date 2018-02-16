# user/group.pp

class zetcd::user::group (
  Boolean $manage_zetcd_group = $::zetcd::manage_zetcd_group,
  String  $zetcd_group        = $::zetcd::zetcd_group,
) {
  if $manage_zetcd_group {
    group { 'zetcd':
      name    => $zetcd_group,
      ensure  => present,
      system  => true,
    }
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

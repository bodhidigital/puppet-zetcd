# user/user.pp

class zetcd::user::user (
  Boolean $manage_zetcd_user  = $::zetcd::manage_zetcd_user,
  String  $zetcd_user         = $::zetcd::zetcd_user,
) {
  require '::zetcd::user::group'

  if $manage_zetcd_user {
    user { 'zetcd':
      name    => $zetcd_user,
      gid     => $zetcd_group,
      home    => '/nonexistant',
      shell   => '/bin/false',
      system  => true,
    }
  }
}

# vim: set ts=2 sw=2 et syn=puppet:

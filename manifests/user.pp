# user.pp

class zetcd::user {
  contain '::zetcd::user::user'
  contain '::zetcd::user::group'
}

# vim: set ts=2 sw=2 et syn=puppet:

class users {
  include users::root

  class { 'users::admins':
    admins => [ 'jack', 'jill' ],
  }
}

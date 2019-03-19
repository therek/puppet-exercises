class users::admins {

  $administrators = [ 'jack', 'jill' ]

  $administrators.each |$admin| {
    user { $admin:
      ensure     => 'present',
      managehome => true,
    }

    file { "/home/${admin}/.ssh":
      ensure  => 'directory',
      mode    => '0700',
      group   => ['wheel'],
      require => User[$admin],
    }

    file { "/home/${admin}/.ssh/id_rsa.pub":
      ensure => 'file',
      source => "puppet:///modules/users/${admin}-id_rsa.pub",
    }
  }
}

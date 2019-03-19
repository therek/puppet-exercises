class puppet::agent {
  file { '/etc/therek-puppet-env':
    ensure  => 'file',
    content => "Environment: ${::environment}",
  }
}

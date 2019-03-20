class puppet::agent ($runinterval = 300){
  file { '/etc/therek-puppet-env':
    ensure  => 'file',
    content => "Environment: ${::environment}\n",
  }

  augeas{ 'set-puppet-runinterval':
    context => '/files/etc/puppetlabs/puppet/puppet.conf/main',
    changes => "set runinterval ${runinterval}",
  }
}

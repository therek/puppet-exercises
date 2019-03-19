class puppet::master {
  package { ['librarian-puppet', 'r10k']:
    ensure   => 'installed',
    provider => 'puppet_gem',
  }

  file { '/etc/puppetlabs/r10k':
    ensure  => 'directory',
    require => Package['r10k'],
  }

  file { '/etc/puppetlabs/r10k/r10k.yaml':
    ensure => 'file',
    source => 'puppet:///modules/puppet/r10k.yaml',
  }
}

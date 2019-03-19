class users::root {
  file_line { 'bash_profile_path':
    path  => '/root/.bash_profile',
    line  => 'PATH=/opt/puppetlabs/puppet/bin/:$PATH:$HOME/bin',
    match => '^PATH\=',
  }
}

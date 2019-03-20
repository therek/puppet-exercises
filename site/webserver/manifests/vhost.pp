define webserver::vhost (
  $server_name,
  $docroot,
){
  file { "/etc/httpd/conf.d/vhost-${server_name}.conf":
    ensure  => 'file',
    content => epp('webserver/vhost.conf.epp',{
      'server_name' => $server_name,
      'docroot'     => $docroot,
      }),
    require => Package['httpd'],
    notify  => Service['httpd'],
  }
}

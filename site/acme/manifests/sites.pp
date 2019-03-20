class acme::sites {
  $sites = [ 'example.com', 'mysite.net' ]

  $sites.each |String $site| {
    webserver::vhost {$site:
      server_name => $site,
      docroot     => "/var/www/html/${site}",
    }
    file { "/var/www/html/${site}":
      ensure => 'directory',
    }
    file { "/var/www/html/${site}/index.html":
      ensure  => 'file',
      content => "<html><body>This is ${site}</body></html>\n"
    }
  }
}

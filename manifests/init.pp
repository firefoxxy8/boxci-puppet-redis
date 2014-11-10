class redis {
  package { 'redis-server':
    ensure      => latest,
    name        => 'redis-server',
  }

  service { 'redis-server':
    enable      => true,
    hasrestart  => true,
  }

  file { '/var/lib/redis':
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
  }

  file { '/etc/redis/redis.conf':
    ensure      => present,
    owner       => "root",
    group       => "root",
    source      => "puppet:///modules/redis/redis.conf",
  }

  File['/var/lib/redis'] -> Package['redis-server'] -> File['/etc/redis/redis.conf'] ~> Service['redis-server']
}

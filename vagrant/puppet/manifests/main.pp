class apt_update {
exec { "aptGetUpdate":
  command => "sudo apt-get update",
  path => ["/bin", "/usr/bin"]
}
}

class mongodb {
exec { "10genKeys":
  command => "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
  path => ["/bin", "/usr/bin"],
  notify => Exec["aptGetUpdate"],
  unless => "apt-key list | grep 10gen"
}

file { "10gen.list":
  path => "/etc/apt/sources.list.d/10gen.list",
  ensure => file,
  content => "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen",
  notify => Exec["10genKeys"]
}

package { "mongodb-10gen":
  ensure => present,
  require => [Exec["aptGetUpdate"],File["10gen.list"]]
}

}

class othertools {

package { "git":
  ensure => latest,
  require => Exec["aptGetUpdate"]
}

package { "vim-common":
  ensure => latest,
  require => Exec["aptGetUpdate"]
}

package { "wget":
  ensure => present,
  require => Exec["aptGetUpdate"]
}

}

class python-libraries {
exec { "getEasyInstall":
  cwd => "/tmp",
  command => "wget http://python-distribute.org/distribute_setup.py",
  creates => "/tmp/distribute_setup.py",
  path => ["/usr/bin", "/bin", "/usr/local/bin"],
  require => Package["wget"],
}

exec { "installEasyInstall":
  cwd => "/tmp",
  command => "python distribute_setup.py",
  require => Exec["getEasyInstall"],
  path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"]
}


exec { "installBottle":
  command => "easy_install bottle",
  path => ["/bin","/usr/bin", "/usr/local/bin"],
  require => Exec["installEasyInstall"],
}
exec { "installPymongo":
  command => "easy_install pymongo",
  path => ["/bin","/usr/bin", "/usr/local/bin"],
  require => Exec["installEasyInstall"],
}
}

include apt_update
include othertools
include mongodb
include python-libraries

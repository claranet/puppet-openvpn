# == Class openvpn::config
#
# This class is called from openvpn for service config.
#
class openvpn::config {

  file { '/etc/openvpn':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/openvpn/openvpn.conf':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('openvpn/openvpn.conf.erb'),
  }

  file { '/etc/openvpn/keys':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/openvpn/ccd':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/openvpn/keys/ca.crt':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => $::openvpn::ca_crt,
  }
  file { '/etc/openvpn/keys/local.crt':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => $::openvpn::cert,
  }
  file { '/etc/openvpn/keys/local.key':
    ensure  => present,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => $::openvpn::key,
  }
  file { '/etc/openvpn/keys/dh.pem':
    ensure  => present,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => $::openvpn::dh,
  }

}

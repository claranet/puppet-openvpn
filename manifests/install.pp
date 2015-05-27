# == Class openvpn::install
#
# This class is called from openvpn for install.
#
class openvpn::install {

  package { $::openvpn::package_name:
    ensure => present,
  }
}

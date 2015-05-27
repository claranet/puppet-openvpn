# == Class openvpn::params
#
# This class is meant to be called from openvpn.
# It sets variables according to platform.
#
class openvpn::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'openvpn'
      $service_name = 'openvpn'
    }
    'RedHat', 'Amazon': {
      $package_name = 'openvpn'
      case $::operatingsystemmajrelease {
        '7': {
          $service_name = 'openvpn@openvpn'
        }
        default: {
          $service_name = 'openvpn'
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

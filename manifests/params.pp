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
      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemmajrelease {
            '8': {
              $service_provider = 'systemd'
            }
            default: {
              $service_name = 'debian'
            }
          }
        }
        'Ubuntu': {
          $service_name = 'upstart'
        }
      }
    }
    'RedHat', 'Amazon': {
      $package_name = 'openvpn'
      case $::operatingsystemmajrelease {
        '7': {
          $service_name = 'openvpn@openvpn'
          $service_provider = 'systemd'
        }
        default: {
          $service_name = 'openvpn'
          $service_provider = 'init'
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

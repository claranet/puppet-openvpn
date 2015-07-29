# == Class openvpn::params
#
# This class is meant to be called from openvpn.
# It sets variables according to platform.
#
class openvpn::params {
  $service_username = 'nobody'
  case $::osfamily {
    'Debian': {
      $package_name = 'openvpn'
      $service_name = 'openvpn'
      $service_groupname = 'nogroup'
      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemmajrelease {
            '8': {
              $service_provider = 'systemd'
            }
            default: {
              $service_provider = 'debian'
            }
          }
        }
        'Ubuntu': {
          $service_provider = 'upstart'
        }
      }
    }
    'RedHat', 'Amazon': {
      $package_name = 'openvpn'
      $service_groupname = 'nobody'
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

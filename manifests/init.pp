# == Class: openvpn
#
# Full description of class openvpn here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class openvpn (
  $ca_crt,
  $cert,
  $key,
  $dh           = undef,
  $mode         = 'client', # client or server
  $network      = undef, # needed only for server
  $netmask      = undef,
  $routes       = [],
  $package_name = $::openvpn::params::package_name,
  $service_name = $::openvpn::params::service_name,
) inherits ::openvpn::params {


  case $mode {
    'server': {
      unless (is_ip_address($network)) {
        fail('You must specify network address')
      }
      unless (is_ip_address($netmask)) {
        fail('You must specify netmask')
      }
    }
    'client': {
    }
    default: {
      fail('mode must be either server or client')
    }
  }

  class { '::openvpn::install': } ->
  class { '::openvpn::config': } ~>
  class { '::openvpn::service': } ->
  Class['::openvpn']
}

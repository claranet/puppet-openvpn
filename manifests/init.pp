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
  $dh            = undef,
  $mode          = 'client', # client or server
  $remote        = undef, # Needed only for client
  $network       = undef, # needed only for server
  $netmask       = undef,
  $routes        = [],
  $push          = [],
  $clientconfig  = {},
  $client2client = false,
  $package_name  = $::openvpn::params::package_name,
  $service_name  = $::openvpn::params::service_name,
  $service_user  = $::openvpn::params::service_user,
  $service_group = $::openvpn::params::service_group,
) inherits ::openvpn::params {

  validate_array($routes)
  validate_array($push)
  case $mode {
    'server': {
      unless (is_ip_address($network)) {
        fail('You must specify network address')
      }
      unless (is_ip_address($netmask)) {
        fail('You must specify netmask')
      }
      create_resources('::openvpn::clientconfig',$clientconfig)
    }
    'client': {
      unless ($remote) {
        fail('You must specify remote in client mode')
      }
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

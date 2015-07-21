# == Class openvpn::service
#
# This class is meant to be called from openvpn.
# It ensure the service is running.
#
class openvpn::service {

  service { $::openvpn::service_name:
    ensure     => running,
    enable     => true,
    provider   => $::openvpn::params::service_provider,
    hasstatus  => true,
    hasrestart => true,
  }
}

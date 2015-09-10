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

  if $::openvpn::params::service_provider == 'systemd' {
    augeas { 'auto-restart openvpn':
      lens    => 'Systemd.lns',
      incl    => '/lib/systemd/system/openvpn@.service',
      changes => 'set /files/lib/systemd/system/openvpn@.service/Service/Restart/value always',
      notify  => Service[$::openvpn::service_name],
    }
  }
}

# Creates client configuration file
define openvpn::clientconfig ($config = []) {

  validate_array($config)

  file { "/etc/openvpn/ccd/${name}":
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    template => template('openvpn/clientconfig.erb'),
  }
}

# Configures the stackify services
class stackify::service (
  String $package_ensure = $stackify::params::package_ensure,
  String $service_ensure = $stackify::params::service_ensure,
  Boolean $service_enable = $stackify::params::service_enable,
  Boolean $service_manage = $stackify::params::service_manage,
  String $service_name_monitoring = $stackify::params::service_name_monitoring,
  String $service_name_health = $stackify::params::service_name_health,

) inherits stackify::params {
  if $package_ensure != 'absent' {
    if ! ($service_ensure in ['running', 'stopped']) {
      fail('service_ensure parameter must be running or stopped')
    }

    if ! ($service_enable in [true, false]) {
      fail('service_enable parameter must be true or false')
    }

    if $service_manage == true {
      service { $service_name_monitoring:
        ensure => $service_ensure,
        enable => $service_enable,
        # TODO: Possibly add subscribe to ProfileProcess.txt if the bug is fixed
      }
      service { $service_name_health:
        ensure => $service_ensure,
        enable => $service_enable,
      }
    }
  }
}

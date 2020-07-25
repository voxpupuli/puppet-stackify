# stackify
#
# Main class, includes all other classes.
#
# @param package_install_options_activationkey [String] Your stackify activation/license key
class stackify (
  String $package_install_options_activationkey,
  String $package_install_options_environment,
  String $package_install_options_device_alias = $stackify::params::package_install_options_device_alias,
  Boolean $package_install_options_attach_all = $stackify::params::package_install_options_attach_all,
  Boolean $package_install_options_enable_profiler = $stackify::params::package_install_options_enable_profiler,
  Boolean $package_install_options_enable_ipmask = $stackify::params::package_install_options_enable_ipmask,
  String $package_ensure = $stackify::params::package_ensure,
  String $package_name= $stackify::params::package_name,
  String $file_download_directory = $stackify::params::file_download_directory,
  String $file_download_name = $stackify::params::file_download_name,
  Stdlib::Absolutepath $file_download_absolute_path = $stackify::params::file_download_absolute_path,
  String $file_download_source = $stackify::params::file_download_source,
  String $service_ensure = $stackify::params::service_ensure,
  Boolean $service_enable = $stackify::params::service_enable,
  Boolean $service_manage = $stackify::params::service_manage,
  String $service_name_monitoring = $stackify::params::service_name_monitoring,
  String $service_name_health = $stackify::params::service_name_health,
) inherits stackify::params {
  class { 'stackify::install':
    package_ensure                          => $package_ensure,
    package_name                            => $package_name,
    file_download_directory                 => $file_download_directory,
    file_download_absolute_path             => $file_download_absolute_path,
    file_download_source                    => $file_download_source,
    package_install_options_environment     => $package_install_options_environment,
    package_install_options_device_alias    => $package_install_options_device_alias,
    package_install_options_attach_all      => $package_install_options_attach_all,
    package_install_options_enable_profiler => $package_install_options_enable_profiler,
    package_install_options_enable_ipmask   => $package_install_options_enable_ipmask,
    package_install_options_activationkey   => $package_install_options_activationkey,
  }
  class { 'stackify::service':
    package_ensure          => $package_ensure,
    service_ensure          => $service_ensure,
    service_enable          => $service_enable,
    service_manage          => $service_manage,
    service_name_monitoring => $service_name_monitoring,
    service_name_health     => $service_name_health,
  }

  Class['stackify::install']
  -> Class['stackify::service']
}

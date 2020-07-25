# Installs stackify
class stackify::install (
  String $package_install_options_activationkey,
  String $package_install_options_environment,
  String $package_install_options_device_alias = $stackify::params::package_install_options_device_alias,
  Boolean $package_install_options_attach_all = $stackify::params::package_install_options_attach_all,
  Boolean $package_install_options_enable_profiler = $stackify::params::package_install_options_enable_profiler,
  Boolean $package_install_options_enable_ipmask = $stackify::params::package_install_options_enable_ipmask,
  String $package_ensure = $stackify::params::package_ensure,
  String $package_name = $stackify::params::package_name,
  String $file_download_directory = $stackify::params::file_download_directory,
  Stdlib::Absolutepath $file_download_absolute_path = $stackify::params::file_download_absolute_path,
  String $file_download_source = $stackify::params::file_download_source,
) inherits stackify::params {
  if ! defined(File[$file_download_directory]) {
    file { $file_download_directory:
      ensure => directory, # Unfortunately i need to not clean this up ever
    }
  }

  file { $file_download_absolute_path:
    ensure  => file,
    source  => $file_download_source,
    require => File[$file_download_directory],
  }

  if empty($package_install_options_environment) {
    fail('The Environment variable was not provided.  This is a required parameter.')
  }
  $package_install_options_attach_all_integer = bool2num($package_install_options_attach_all)
  $package_install_options_enable_profiler_integer = bool2num($package_install_options_enable_profiler)
  $package_install_options_enable_enable_ipmask_integer = bool2num($package_install_options_enable_ipmask)
  $package_install_options = [
    '/s',
    "/v\"ACTIVATIONKEY=${package_install_options_activationkey}",
    "ENVIRONMENT=\"${package_install_options_environment}\"",
    "DEVICEALIAS=\"${package_install_options_device_alias}\"",
    "IPMASK=${package_install_options_enable_enable_ipmask_integer}",
    "ENABLEPROFILER=${package_install_options_enable_profiler_integer}",
    'ENABLEREMOTE=True',
    'RESTARTIIS=0',
    "ATTACHALL=${package_install_options_attach_all_integer}",
    '/qn' ,
    '/l*v',
  'C:\StackifyInstallLog.txt"']

  package { $package_name:
    ensure          => $package_ensure,
    source          => $file_download_absolute_path,
    install_options => $package_install_options,
    provider        => 'windows',
  }
}

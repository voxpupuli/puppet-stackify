# Parameters available to customize stackify
class stackify::params {
  $package_ensure = 'present'
  $package_name = 'StackifyAgentProd'
  $package_install_options_device_alias = $facts['networking']['hostname']
  $package_install_options_attach_all = true
  $package_install_options_enable_profiler = true
  $package_install_options_enable_ipmask = false
  $file_download_directory = 'C:\Binaries'
  $file_download_name = 'Stackify-Install-Latest.exe'
  $file_download_absolute_path = "${file_download_directory}\\${file_download_name}"
  $file_download_source = 'http://s1.stackify.com/Account/AgentDownload'
  $service_ensure = 'running'
  $service_enable = true
  $service_manage = true
  $service_name_monitoring = 'StackifyMonitoringService'
  $service_name_health = 'StackifyHealthService'
}

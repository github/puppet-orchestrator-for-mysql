# @summary MySQL orchestrator: For managing replication and failover.
#
# @param config
#   full path to configuration file
# @param config_defaults
#   default configuration for orchestrator
# @param config_override
#   configuration overlay
# @param config_template
#   path to configuration file template
# @param package_ensure
#   ensure package resource
# @param package_manage
#   if true module will manage package
# @param package_name
#   list of packages install. Default ['orchestrator']
# @param repo_manage
#   if true module will manage repo with orchestrator package
# @param service_enable
#   if true service orchestrator will be enaled at boot
# @param service_ensure
#   ensure service resource
# @param service_manage
#   if true module willl manage service
# @param service_name
#   service name to manage. Default 'orchestrator'
class orchestrator (
  String $config                        = $orchestrator::params::config,
  Hash[String[1], Any] $config_defaults = $orchestrator::params::config_defaults,
  Hash[String[1], Any] $config_override = {},
  String $config_template               = $orchestrator::params::config_template,
  String $package_ensure                = $orchestrator::params::package_ensure,
  Boolean $package_manage               = $orchestrator::params::package_manage,
  Array[String[1]] $package_name        = $orchestrator::params::package_name,
  Boolean $repo_manage                  = $orchestrator::params::repo_manage,
  Boolean $service_enable               = $orchestrator::params::service_enable,
  String $service_ensure                = $orchestrator::params::service_ensure,
  Boolean $service_manage               = $orchestrator::params::service_manage,
  String $service_name                  = $orchestrator::params::service_name,
) inherits orchestrator::params {
  validate_absolute_path($config)
  validate_string($config_template)
  validate_string($package_ensure)
  validate_bool($package_manage)
  validate_array($package_name)
  validate_bool($repo_manage)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)

  contain orchestrator::repo
  contain orchestrator::install
  contain orchestrator::config
  contain orchestrator::my_cnf
  contain orchestrator::service

  Class['orchestrator::repo']
  -> Class['orchestrator::install']
  -> Class['orchestrator::config']
  ~> Class['orchestrator::my_cnf']
  -> Class['orchestrator::service']
}

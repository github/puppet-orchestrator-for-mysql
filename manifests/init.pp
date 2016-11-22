#
# MySQL orchestrator: For managing replication and failover.
#
class orchestrator (
  $config            = $orchestrator::params::config,
  $config_defaults   = $orchestrator::params::config_defaults,
  $config_override   = {},
  $config_template   = $orchestrator::params::config_template,
  $package_ensure    = $orchestrator::params::package_ensure,
  $package_manage    = $orchestrator::params::package_manage,
  $package_name      = $orchestrator::params::package_name,
  $service_enable    = $orchestrator::params::service_enable,
  $service_ensure    = $orchestrator::params::service_ensure,
  $service_manage    = $orchestrator::params::service_manage,
  $service_name      = $orchestrator::params::service_name,
) inherits orchestrator::params {

  validate_absolute_path($config)
  validate_string($config_template)
  validate_string($package_ensure)
  validate_bool($package_manage)
  validate_array($package_name)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)

  # Based on https://github.com/puppetlabs/puppetlabs-ntp/blob/8db718ca76d05861b898e26764df1edb79bec989/manifests/init.pp#L65-L67
  #
  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'orchestrator::begin': } ->
  class { '::orchestrator::install': } ->
  class { '::orchestrator::config': } ~>
  class { '::orchestrator::my_cnf': } ~>
  class { '::orchestrator::service': } ->
  anchor { 'orchestrator::end': }

}

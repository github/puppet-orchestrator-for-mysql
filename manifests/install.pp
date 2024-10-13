#
class orchestrator::install inherits orchestrator {
  if $orchestrator::package_manage {
    package { $orchestrator::package_name:
      ensure => $orchestrator::package_ensure,
    }
  }
}

#
class orchestrator::service inherits orchestrator {

  if ! ($orchestrator::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $orchestrator::service_manage == true {

    service { 'orchestrator':
      ensure     => $orchestrator::service_ensure,
      enable     => $orchestrator::service_enable,
      hasrestart => true,
      hasstatus  => true,
      name       => $orchestrator::service_name,
      subscribe  => File[$orchestrator::config],
    }

  }

}

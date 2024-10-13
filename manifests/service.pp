#
class orchestrator::service inherits orchestrator {
  if ! ($orchestrator::service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $orchestrator::service_manage == true {
    if 'systemd' in $facts['init_systems'] {
      include systemd

      systemd::manage_dropin { '10_user.conf':
        ensure        => 'present',
        unit          => 'orchestrator.service',
        service_entry => {
          'User'  => $orchestrator::service_user,
          'Group' => $orchestrator::service_group,
        },
        notify        => Service['orchestrator'],
      }
    }

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

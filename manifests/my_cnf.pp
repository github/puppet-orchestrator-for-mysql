#
class orchestrator::my_cnf inherits orchestrator {
  $cnf_erb = 'orchestrator/orchestrator.cnf.erb'

  file { $orchestrator::topology_cnf:
    ensure  => file,
    owner   => $orchestrator::service_user,
    group   => $orchestrator::service_group,
    mode    => '0640',
    content => template($cnf_erb),
  }
  file { $orchestrator::srv_cnf:
    ensure  => file,
    owner   => $orchestrator::service_user,
    group   => $orchestrator::service_group,
    mode    => '0640',
    content => template($cnf_erb),
  }
}

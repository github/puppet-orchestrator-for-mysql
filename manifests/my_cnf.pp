#
class orchestrator::my_cnf inherits orchestrator {

  file { $orchestrator::topology_cnf:
    content => template("puppet-orchestrator-for-mysql/${orchestrator::topology_cnf}.erb"),
    mode    => '0644',
  }
  file { $orchestrator::srv_cnf:
    content => template("puppet-orchestrator-for-mysql/${orchestrator::srv_cnf}.erb"),
    mode   => '0644',
  }
}

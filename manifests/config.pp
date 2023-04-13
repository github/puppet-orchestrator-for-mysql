#
class orchestrator::config inherits orchestrator {
  # Create a merged together set of options.  Rightmost hashes win over left. Requires stdlib
  $options = merge($orchestrator::config_defaults, $orchestrator::config_override)

  file { $orchestrator::config:
    ensure  => file,
    owner   => $orchestrator::service_user,
    group   => $orchestrator::service_group,
    mode    => '0640',
    content => template($orchestrator::config_template),
  }
}

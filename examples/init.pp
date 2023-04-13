node default {
  $user = 'root'
  $password = 'root'

  class { 'mysql::server':
    root_password           => "%${password}%",
    remove_default_accounts => true,
  }
  -> class { 'orchestrator':
    config_override => {
      'MySQLOrchestratorHost' => '127.0.0.1',
    },
  }
}

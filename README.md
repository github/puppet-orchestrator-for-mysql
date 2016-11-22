# puppet-orchestrator-for-mysql

This module is to install the MySQL tool called Orchestrator via puppet. Orchestrator is used for managing replication topologies. See https://github.com/github/orchestrator for instructions on appopriate configuration and setup.

# Usage

```
  $config_override = {
    'Debug'                                      => true,
    'ReadOnly'                                   => false,
    'MySQLOrchestratorHost'                      => 'orchestrator.example.com',
    'MySQLOrchestratorPort'                      => 3306,
    'MySQLOrchestratorDatabase'                  => 'orchestrator',
    'RemoveTextFromHostnameDisplay'              => '.example.com:3306',
    'SlaveLagQuery'                              => 'select lag from test.heartbeat_table',
    'DiscoverByShowSlaveHosts'                   => false,
    'DetectClusterAliasQuery'                    => 'select cluster_alias from test.cluster_info_table where 1=1',
    'DetectClusterDomainQuery'                   => "select cluster_domain from test.cluster_info_table where 1=1',
    'DataCenterPattern'                          => '.*-(.*)-.*[.].*[.]example[.]com',
    'PhysicalEnvironmentPattern'                 => '.*-.*-(.*)[.].*[.]example[.]com',
    'PseudoGTIDPattern'                          => '`heartbeat` (ts, server_id, file, position, relay_master_log_file, exec_master_log_pos) VALUES',
    'PseudoGTIDPatternIsFixedSubstring'          => true,
    'PseudoGTIDMonotonicHint'                    => 'heartbeat',
    'DetectPseudoGTIDQuery'                      => 'select count(*)>0 as pseudo_gtid_exists from test.heartbeat_table where ts > NOW() - INTERVAL 2 DAY;',
    'ProblemIgnoreHostnameFilters'               => [
      'test-server-mysql',
    ],
    'PromotionIgnoreHostnameFilters'             => [
      'test-server-mysql',
    ],
    'AuditLogFile'                               => '',
    'AuthenticationMethod'                       => 'token',
    'FailureDetectionPeriodBlockMinutes'         => 60,
    'RecoveryPollSeconds'                        => 5,
    'RecoveryPeriodBlockSeconds'                 => 600,
    'RecoveryIgnoreHostnameFilters'              => [],
    'RecoverMasterClusterFilters'                => [
      'mysqla',
      'mysqlb',
    ],
    'RecoverIntermediateMasterClusterFilters'    => [
      'mysqlb',
      'mysqlc',
    ],
    'OnFailureDetectionProcesses'                => [
      "sudo -i recovery-handler -t 'detection' -f '{failureType}' -h '{failedHost}' -C '{failureCluster}' -n '{countSlaves}'"
    ],
    'PreFailoverProcesses'                       => [
      "sudo -i recovery-handler -t 'pre-failover' -f '{failureType}' -h '{failedHost}' -C '{failureCluster}' -n '{countSlaves}'"
    ],
    'PostFailoverProcesses'                      => [
      "sudo -i recovery-handler -t 'post-failover' -f '{failureType}' -h '{failedHost}' -H '{successorHost}' -C '{failureCluster}' -n '{countSlaves}'"
    ],
    'PostUnsuccessfulFailoverProcesses'          => [],
    'PostMasterFailoverProcesses'                => [
      "sudo setuidgid orc_user ssh {failedHost}    'sudo -i do_something_on_failed_host > /dev/null 2> /dev/null'",
      "sudo setuidgid orc_user ssh {successorHost} 'sudo -i do_something_on_new_host > /dev/null 2> /dev/null'",
    ],
    'PostIntermediateMasterFailoverProcesses'    => [
    ],
    'CoMasterRecoveryMustPromoteOtherCoMaster'   => true,
    'DetachLostSlavesAfterMasterFailover'        => true,
    'ApplyMySQLPromotionAfterMasterFailover'     => false,
    'MasterFailoverLostInstancesDowntimeMinutes' => 60,
    'PostponeSlaveRecoveryOnLagMinutes'          => 10,
    'GraphitePollSeconds'                        => 60,
    'GraphiteAddr'                               => 'graphite.example.com:2113',
    'GraphitePath'                               => 'hosts.{hostname}.orchestrator',
    'GraphiteConvertHostnameDotsToUnderscores'   => true,
  }

  class { '::orchestrator':
    config_override => $config_override,
    package_ensure  => 'latest',
    package_manage  => true,
  }
```
# Assumptions

* Puppetlab's stdlib is used by this module.

* The orchestrator deb/rpm package is available to puppet if `orchestrator::params::package_manage` is `true`.

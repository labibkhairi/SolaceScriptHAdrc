# SolaceScriptHAdrc
Shell scripts for installing solace in HA Active Standby DRC

Shell script for installing Solace in HA Active Standby

Note:

solace-primary-drc is hostname of active node, solace-backup-drc is hostname of standby node, solace-monitoring-drc is hostname of monitoring node

Run Solace Primary DRC

[opc@solace-primary solacescripts]$ bash HAPrimaryDRC.sh

Run Solace Backup DRC

[opc@solace-backup solacescripts]$ bash HABackupDRC.sh

Run Solace Monitoring DRC

[opc@solace-monitoring solacescripts]$ bash HAMonitorDRC.sh

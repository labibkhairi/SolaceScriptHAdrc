#Add user
groupadd -g 501 solgroup
useradd -u 1001 -g 501 sysadmin
sudo useradd -u 1001 -g 501 sysadmin
passwd sysadmin
sudo usermod -aG solgroup sysadmin

#you can remove lines 10-21 if this is a fresh environment; otherwise remove the existing instance and externalize volumes
docker ps -a
docker stop solace-primary-drc
docker rm -f solace-primary-drc
docker ps -a

sudo rm -rf /opt/vmr/internalSpool
sudo rm -rf /opt/vmr/diags
sudo rm -rf /opt/vmr/jail
sudo rm -rf /opt/vmr/softAdb
sudo rm -rf /opt/vmr/var
sudo rm -rf /opt/vmr/adb
sudo ls -la /opt/vmr/

#make directory
sudo mkdir -p /opt/vmr/internalSpool
sudo mkdir -p /opt/vmr/diags
sudo mkdir -p /opt/vmr/jail
sudo mkdir -p /opt/vmr/softAdb
sudo mkdir -p /opt/vmr/var
sudo mkdir -p /opt/vmr/adb
sudo chown -R sysadmin:solgroup /opt/vmr
sudo ls -la /opt/vmr/


docker run \
--user=1001 \
--publish 55555:55555 \
--publish 2223:2222 \
--publish 8300:8300 \
--publish 8301:8301 \
--publish 8302:8302 \
--publish 8741:8741 \
--publish 8301:8301/udp \
--publish 8302:8302/udp \
--publish 8081:8080 \
--publish 1943:1943 \
--publish 55443:55443 \
--publish 55556:55556 \
--publish 8008:8008 \
--publish 5550:5550 \
--publish 9000:9000 \
--publish 9443:9443 \
--publish 5671:5671 \
--publish 1883:1883 \
--publish 8883:8883 \
--publish 8000:8000 \
--publish 8443:8443 \
--shm-size=2g \
--ulimit core=-1 \
--ulimit memlock=-1 \
--ulimit nofile=2448:42192 \
--restart=always \
--hostname=solacePrimaryDRC \
--add-host solace-primary-drc:10.17.101.18 \
--detach=true \
--memory-swap=-1 \
--memory-reservation=0 \
--env 'username_admin_globalaccesslevel=admin' \
--env 'username_admin_password=admin' \
--env 'nodetype=message_routing' \
--env 'routername=primary' \
--env 'redundancy_matelink_connectvia=solace-backup-drc' \
--env 'redundancy_activestandbyrole=primary' \
--env 'redundancy_group_password=password' \
--env 'redundancy_enable=yes' \
--env 'redundancy_group_node_primary_nodetype=message_routing' \
--env 'redundancy_group_node_primary_connectvia=solace-primary-drc' \
--env 'redundancy_group_node_backup_nodetype=message_routing' \
--env 'redundancy_group_node_backup_connectvia=solace-backup-drc' \
--env 'redundancy_group_node_monitor_nodetype=monitoring' \
--env 'redundancy_group_node_monitor_connectvia=solace-monitoring-drc' \
--env 'configsync_enable=yes' \
--name=solace-primary-drc solace/solace-pubsub-standard:10.2.1.32

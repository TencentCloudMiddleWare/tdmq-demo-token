#!/bin/sh
admin_url=http://9.223.79.203:8080
tenant="xty"
name_space=$tenant/default


sh pulsar-admin topics delete-partitioned-topic $name_space/xty_1_1
echo 'delete topic' $name_space/xty_1_1 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_1_2
echo 'delete topic' $name_space/xty_1_2 'suc'

sh pulsar-admin topics delete $name_space/xty_2_1_1
echo 'delete topic' $name_space/xty_2_1_1 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_2_1_2
echo 'delete topic' $name_space/xty_2_1_2 'suc'

sh pulsar-admin topics delete-partitioned-topic $name_space/xty_2_3
echo 'delete topic' $name_space/xty_2_3 'suc'

sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_1
echo 'delete topic' $name_space/xty_3_1 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_2
echo 'delete topic' $name_space/xyt/_3_2 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/sub_3_2-retry
echo 'delete topic' $name_space/sub_3_2-retry 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/sub_3_2-dlq
echo 'delete topic' $name_space/sub_3_2-dlq ' suc'

sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_4
echo 'delete topic' $name_space/xty_3_4 ' suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_5_1
echo 'delete topic' $name_space/xty_3_5_1 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_5_2
echo 'delete topic' $name_space/xty_3_5_2 'suc'

sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_6
echo 'delete topic' $name_space/xty_3_6 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_7
echo 'delete topic' $name_space/xty_3_7 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_3_8
echo 'delete topic' $name_space/xty_3_8 'suc'

sh pulsar-admin topics delete-partitioned-topic $name_space/xty_4_1
echo 'delete topic' $name_space/xty_4_1 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_4_2 
echo 'delete topic' $name_space/xty_4_2 'suc'
sh pulsar-admin topics delete-partitioned-topic $name_space/xty_4_4 
echo 'delete topic' $name_space/xty_4_4 'suc'

sh pulsar-admin topics delete-partitioned-topic $name_space/xty_7_2 
echo 'delete topic' $name_space/xty_7_2 'suc'

sh pulsar-admin namespaces delete $name_space
echo 'delete namespaces' $name_space 'suc'
sh pulsar-admin tenants delete $tenant
echo 'delete tenants' $tenant 'suc'

#!/bin/sh
admin_url=http://9.223.79.203:8080
tenant="xty"
name_space=$tenant/default

sh pulsar-admin tenants create $tenant
echo 'create tenants' $tenant 'suc'
sh pulsar-admin namespaces create $name_space
echo 'create namespaces' $name_space 'suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_1_1 -p 2
echo 'create topic' $name_space/xty_1_1 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_1_2 -p 4
echo 'create topic' $name_space/xty_1_2 'suc'

sh pulsar-admin topics create $name_space/xty_2_1_1
echo 'create topic' $name_space/xty_2_1_1 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_2_1_2 -p 3
echo 'create topic' $name_space/xty_2_1_2 'suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_2_3 -p 2
echo 'create topic' $name_space/xty_2_3 'suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_1 -p 2
echo 'create topic' $name_space/xty_3_1 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_2 -p 2
echo 'create topic' $name_space/xyt/_3_2 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/sub_3_2-retry -p 1
echo 'create topic' $name_space/sub_3_2-retry 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/sub_3_2-dlq -p 1
echo 'create topic' $name_space/sub_3_2-dlq ' suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_4 -p 2
echo 'create topic' $name_space/xty_3_4 ' suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_5_1 -p 2
echo 'create topic' $name_space/xty_3_5_1 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_5_2 -p 1
echo 'create topic' $name_space/xty_3_5_2 'suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_6 -p 1
echo 'create topic' $name_space/xty_3_6 'suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_7 -p 1
echo 'create topic' $name_space/xty_3_7 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_8 -p 1
echo 'create topic' $name_space/xty_3_8 'suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_4_1 -p 1
echo 'create topic' $name_space/xty_4_1 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_4_2 -p 1
echo 'create topic' $name_space/xty_4_2 'suc'
sh pulsar-admin topics create-partitioned-topic $name_space/xty_4_4 -p 5
echo 'create topic' $name_space/xty_4_4 'suc'

sh pulsar-admin topics create-partitioned-topic $name_space/xty_7_2 -p 2
echo 'create topic' $name_space/xty_7_2 'suc'

echo 'create subscription'

sh pulsar-admin topics create-subscription -s sub_1_1 $name_space/xty_1_1
echo 'create subscription  sub_1_1 on ' $name_space/xty_1_1 'suc'

sh pulsar-admin topics create-subscription -s sub_1_2 $name_space/xty_1_2
echo 'create subscription  sub_1_2 on ' $name_space/xty_1_2 'suc'

sh pulsar-admin topics create-subscription -s sub_2_1_1 $name_space/xty_2_1_1
echo 'create subscription  sub_2_1_1 on ' $name_space/xty_2_1_1 'suc'

sh pulsar-admin topics create-subscription -s sub_2_1_2 $name_space/xty_2_1_2
echo 'create subscription  sub_2_1_2 on ' $name_space/xty_2_1_2 'suc'

sh pulsar-admin topics create-subscription -s sub_2_3 $name_space/xty_2_3
echo 'create subscription  sub_2_3 on ' $name_space/xty_2_3 'suc'

sh pulsar-admin topics create-subscription -s sub_3_1 $name_space/xty_3_1
echo 'create subscription  sub_3_1 on ' $name_space/xty_3_1 'suc'

sh pulsar-admin topics create-subscription -s sub_3_2 $name_space/xty_3_2
echo 'create subscription  sub_3_2 on ' $name_space/xty_3_2 'suc'
sh pulsar-admin topics create-subscription -s sub_3_2 $name_space/sub_3_2-retry
echo 'create subscription  sub_3_2 on ' $name_space/sub_3_2-retry 'suc'
sh pulsar-admin topics create-subscription -s sub_3_2 $name_space/sub_3_2-dlq
echo 'create subscription  sub_3_2 on ' $name_space/sub_3_2-dlq 'suc'

sh pulsar-admin topics create-subscription -s sub_3_4 $name_space/xty_3_4
echo 'create subscription  sub_3_4 on ' $name_space/xty_3_4 'suc'

sh pulsar-admin topics create-subscription -s sub_3_5 $name_space/xty_3_5_1
echo 'create subscription  sub_3_5 on ' $name_space/xty_3_5_1 'suc'
sh pulsar-admin topics create-subscription -s sub_3_5 $name_space/xty_3_5_2
echo 'create subscription  sub_3_5 on ' $name_space/xty_3_5_2 'suc'

sh pulsar-admin topics create-subscription -s sub_3_6 $name_space/xty_3_6
echo 'create subscription  sub_3_6 on ' $name_space/xty_3_6 'suc'
#sh pulsar-admin topics reset-cursor --messageId 4782:0 -s sub_3_6 $name_space/xty_3_6-partition-0
 
sh pulsar-admin topics create-subscription -s sub_3_8 $name_space/xty_3_8
echo 'create subscription  sub_3_8 on ' $name_space/xty_3_8 'suc'

sh pulsar-admin topics create-subscription -s sub_4_1 $name_space/xty_4_1
echo 'create subscription  sub_4_1 on ' $name_space/xty_4_1 'suc'
sh pulsar-admin topics create-subscription -s sub_4_2 $name_space/xty_4_2
echo 'create subscription  sub_4_2 on ' $name_space/xty_4_2 'suc'

sh pulsar-admin topics create-subscription -s sub_4_4 $name_space/xty_4_4
echo 'create subscription  sub_4_4 on ' $name_space/xty_4_4 'suc'

sh pulsar-admin topics create-subscription -s sub_7_2 $name_space/xty_7_2
echo 'create subscription  sub_7_2 on ' $name_space/xty_7_2 'suc'

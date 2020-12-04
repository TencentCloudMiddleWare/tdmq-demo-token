
#!/bin/sh
admin_url=http://9.223.79.203:8080
tenant="xty"
name_space=$tenant/default

sh pulsar-admin tenants creat $tenant
sh pulsar-admin namespaces create $name_space
sh pulsar-admin topics 

sh pulsar-admin topics create-partitioned-topic $name_space/xty_1_1 -p 2
sh pulsar-admin topics create-partitioned-topic $name_space/xty_1_2 -p 4

sh pulsar-admin topics create-topic $name_space/xty_2_1_1
sh pulsar-admin topics create-partitioned-topic $name_space/xty_2_1_2 -p 3

sh pulsar-admin topics create-partitioned-topic $name_space/xty_2_3 -p 2

sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_1 -p 2
sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_2 -p 2
sh pulsar-admin topics create-partitioned-topic $name_space/sub_3_2-retry -p 1
sh pulsar-admin topics create-partitioned-topic $name_space/sub_3_2-dlq -p 1


sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_4 -p 2
sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_5_1 -p 2
sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_5_2 -p 1

sh pulsar-admin topics create-partitioned-topic $name_space/xty_3_6 -p 1

sh pulsar-admin topics create-partitioned-topic $name_space/xty_4_1 -p 1
sh pulsar-admin topics create-partitioned-topic $name_space/xty_4_2 -p 1
sh pulsar-admin topics create-partitioned-topic $name_space/xty_4_4 -p 5

sh pulsar-admin topics create-partitioned-topic $name_space/xty_7_2 -p 2



sh pulsar-admin topics create-subscription -s sub_1_1 $name_space/xty_1_1

sh pulsar-admin topics create-subscription -s sub_1_2 $name_space/xty_1_2

sh pulsar-admin topics create-subscription -s sub_2_1_1 $name_space/xty_2_1_1

sh pulsar-admin topics create-subscription -s sub_2_1_2 $name_space/xty_2_1_2

sh pulsar-admin topics create-subscription -s sub_2_3 $name_space/xty_2_3

sh pulsar-admin topics create-subscription -s sub_3_1 $name_space/xty_3_1

sh pulsar-admin topics create-subscription -s sub_3_2 $name_space/xty_3_2
sh pulsar-admin topics create-subscription -s sub_3_2 $name_space/sub_3_2-retry
sh pulsar-admin topics create-subscription -s sub_3_2 $name_space/sub_3_2-dlq

sh pulsar-admin topics create-subscription -s sub_3_4 $name_space/xty_3_4

sh pulsar-admin topics create-subscription -s sub_3_5 $name_space/xty_3_5_1
sh pulsar-admin topics create-subscription -s sub_3_5 $name_space/xty_3_5_2

sh pulsar-admin topics create-subscription -s sub_3_6 $name_space/xty_3_6
sh pulsar-admin topics reset-cursor --messageId 4782:0 -s sub_3_6 $name_space/xty_3_6-partition-0
 
sh pulsar-admin topics create-subscription -s sub_3_7 $name_space/xty_3_7

sh pulsar-admin topics create-subscription -s sub_4_1 $name_space/xty_4_1
sh pulsar-admin topics create-subscription -s sub_4_2 $name_space/xty_4_2

sh pulsar-admin topics create-subscription -s sub_4_4 $name_space/xty_4_4


sh pulsar-admin topics create-subscription -s sub_7_2 $name_space/xty_7_2
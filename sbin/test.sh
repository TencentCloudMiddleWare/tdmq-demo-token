#!/bin/sh
broker_url=pulsar://9.223.79.203:6650
admin_url=http://9.223.79.203:8080
#name_space='251009823/default'
name_space='xty/default'
echo "1.1"
echo "Java client "
topic=$name_space/xty_1_1
sh runserver.sh com.tentenct.midas.tdmq.test.SimpleProducerAndCosnumer $broker_url $topic sub_1_1
echo "----------------------------------------------------------------"
echo "1.2"
topic=$name_space/xty_1_2
sh runserver.sh com.tentenct.midas.tdmq.test.CustomProducerAndCosnumer $broker_url $topic sub_1_2
echo "----------------------------------------------------------------"
echo "1.3"
topic=$name_space/xty_1_2
sh runserver.sh com.tentenct.midas.tdmq.test.AdminApi $admin_url $topic
echo "----------------------------------------------------------------"
echo "2.1.1"
topic=$name_space/xty_2_1_1
sh runserver.sh com.tentenct.midas.tdmq.test.GlobalOrderMsg $broker_url $topic sub_2_1_1
echo "2.1.2"
topic=$name_space/xty_2_1_2
sh runserver.sh com.tentenct.midas.tdmq.test.LocaleOrderMsg $broker_url $topic sub_2_1_2
echo "----------------------------------------------------------------"
echo "2.3"
topic=$name_space/xty_2_3
sh runserver.sh com.tentenct.midas.tdmq.test.KafkaApi $broker_url $topic sub_2_3
echo "----------------------------------------------------------------"
echo "3.1"
topic=$name_space/xty_3_1
sh runserver.sh com.tentenct.midas.tdmq.test.DelayMessage $broker_url $topic sub_3_1 20
echo "----------------------------------------------------------------"
echo "3.2 3.3"
topic=$name_space/xty_3_2
sh runserver.sh com.tentenct.midas.tdmq.test.RetryMessage $broker_url $topic sub_3_2
echo "----------------------------------------------------------------"
echo "3.4"
topic=$name_space/xty_3_4
sh runserver.sh com.tentenct.midas.tdmq.test.ConsumerModel $broker_url $topic sub_3_4
echo "----------------------------------------------------------------"
echo "3.5"
topic1=$name_space/xty_3_5_1
topic2=$name_space/xty_3_5_2
topic3=$name_space'/xty_3_5_.*'
sh runserver.sh com.tentenct.midas.tdmq.test.SubModel $broker_url $topic1 $topic2 $topic3 sub_3_5
echo "----------------------------------------------------------------"
echo "3.6"
topic=$name_space/xty_3_6
sh runserver.sh com.tentenct.midas.tdmq.test.BacktrackMsg $broker_url $topic sub_3_6
echo "----------------------------------------------------------------"
echo "3.8"
sh runserver.sh com.tentenct.midas.tdmq.test.FilterMessage $broker_url $name_space/xty_3_8 sub_3_8 'TagA'
echo "----------------------------------------------------------------"
echo "4.1"
sh runserver.sh com.tentenct.midas.tdmq.test.AdvancedFeatures $broker_url $name_space/xty_4_1 sub_4_1 compressionMsg
echo "----------------------------------------------------------------"
echo "4.2"
sh runserver.sh com.tentenct.midas.tdmq.test.AdvancedFeatures $broker_url $name_space/xty_4_2 sub_4_2 deduplicat
echo "----------------------------------------------------------------"
echo "4.4"
sh runserver.sh com.tentenct.midas.tdmq.test.AdvancedFeatures $broker_url $name_space/xty_4_4 sub_4_4 messageRouter
echo "----------------------------------------------------------------"
echo "7.2"
sh runserver.sh com.tentenct.midas.tdmq.test.AdvancedFeatures $broker_url $name_space/xty_7_2 sub_7_2 encryption


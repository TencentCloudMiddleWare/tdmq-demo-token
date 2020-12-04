基本用例：
在tdmq_deom
1、test_init.sh 为初始化配置，创建租户、命名空间和Topic相关。
2、test.sh 为用例执行的脚本，每个用例会会输出文档对于的二级目录编号。
3、test_drop.sh 删除相关配置信息。

压测脚本：
在perf_tool
1、sh pulsar-perf produce -b 2 -z LZ4 -o 2000  -r 100000  -n 4 -s 1024 xty/default/xyt_1_1 
1、sh pulsar-perf consume -r 80000  -s sub_1_1 -st Shared xty/default/xyt_1_1 
# tdmq-demo-token
脚本示例：

java -jar ./tdmq-demo.jar producers -p 'fisrtProducer' -b 'pulsar://10.120.11.153:6650' -t pulsar-p37angkrqd -ln 'custom:1255429582/vpc-c207shu4/subnet-95l44pp7' --count 1 --namespace default --topic test123 -token eyJrZXlJZCI6IjEyNTUwMDExMzMiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkZWZhdWx0In0.cDi99x4IAt57fSzY2rfm9tJtlFjSefM73tIeUljxFDE



java -jar ./tdmq-demo.jar consumers -c 'fisrtConsumer' -b 'pulsar://10.120.11.153:6650' -t pulsar-p37angkrqd -ln 'custom:1255429582/vpc-c207shu4/subnet-95l44pp7' --count 10000 --namespace default --topic test123 -token eyJrZXlJZCI6IjEyNTUwMDExMzMiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkZWZhdWx0In0.cDi99x4IAt57fSzY2rfm9tJtlFjSefM73tIeUljxFDE

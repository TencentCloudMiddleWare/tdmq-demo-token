import pulsar

client = pulsar.Client('pulsar://localhost:6650')

producer = client.create_producer('251009823/default/xty_1_1')

for i in range(10):
    value = 'Hello-%d' % i
    producer.send(value.encode('utf-8'))

consumer = client.subscribe('251009823/default/xty_1_1', 'sub_1_1')


for i in range(10):
    msg = consumer.receive()
    try:
        print("Received message '{}' id='{}'".format(msg.data(), msg.message_id()))
        consumer.acknowledge(msg)
    except:
        consumer.negative_acknowledge(msg)

client.close()
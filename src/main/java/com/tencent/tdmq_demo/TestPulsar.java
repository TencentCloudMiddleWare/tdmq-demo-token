package com.tencent.tdmq_demo;

import java.util.concurrent.TimeUnit;

import org.apache.pulsar.client.api.AuthenticationFactory;
import org.apache.pulsar.client.api.ClientBuilder;
import org.apache.pulsar.client.api.Consumer;
import org.apache.pulsar.client.api.Message;
import org.apache.pulsar.client.api.MessageId;
import org.apache.pulsar.client.api.Producer;
import org.apache.pulsar.client.api.PulsarClient;
import org.apache.pulsar.client.api.PulsarClientException;
import org.apache.pulsar.client.impl.BatchMessageIdImpl;
import org.apache.pulsar.client.impl.MessageIdImpl;
import org.apache.pulsar.client.impl.TopicMessageIdImpl;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import com.beust.jcommander.Parameters;

@Parameters(commandDescription = "Operations about produce or consume")
public class TestPulsar{
	
	@Parameter(names = { "-h", "--help", }, help = true, description = "Show this help.")
    boolean help;

    @Parameters(commandDescription = "Create a produce")
    private class ProducerCmd {
        @Parameter(names = {"-broker", "-b"}, description = "broker url", required = true)
        private String brokerURL;

        @Parameter(names = { "--producer", "-p" }, description = "producer name", required = true)
        private String producer;

        @Parameter(names = { "--namespace",
                "-ns" }, description = "namespace setting", required = false)
        private String namespace;
        
        @Parameter(names = { "--listener-name",  "-ln"},  
                description = "listenerName setting, if vpc, must start with 'custom:'", required = false)
        private String listenerName;
        
        @Parameter(names = { "--tenant",  "-t"},  
                description = "tenant setting", required = false)
        private String tenant;
        
        @Parameter(names = { "--topic", "-topic"},  
                description = "tenant setting", required = true)
        private String topic; 
        
        @Parameter(names = { "--count", "-count"},  
                description = "message count", required = false)
        private int count = 1; 
        
        @Parameter(names = { "--authPluginClassName", "-apc"},  
                description = "authPluginClassName setting", required = false)
        private String authPluginClassName; 
        
        @Parameter(names = { "--authParamsString", "-aps"},  
                description = "authParamsString setting", required = false)
        private String authParamsString; 
        
        @Parameter(names = { "--token", "-token"},  
                description = "token setting", required = false)
        private String token;
        
        @Parameter(names = { "--help", "-h"},  
                description = "for a help", required = false)
        private boolean help;
    }

    @Parameters(commandDescription = "Create a consume")
    private class ConsumerCmd {
        @Parameter(names = {"-broker", "-b"}, description = "broker url", required = true)
        private String brokerURL;

        @Parameter(names = { "--consumer",
                "-c" }, description = "consumer name", required = true)
        private String consumer;

        @Parameter(names = { "--namespace",
                "-ns" }, description = "namespace setting", required = false)
        private String namespace;
        
        @Parameter(names = { "--listener-name",  "-ln"},  
                description = "listenerName setting, if vpc, must start with 'custom:'", required = false)
        private String listenerName;
        
        @Parameter(names = { "--tenant",  "-t"},  
                description = "tenant setting", required = false)
        private String tenant;
        
        @Parameter(names = { "--topic"},  
                description = "topic setting", required = true)
        private String topic; 
        
        @Parameter(names = { "--acknowledge", "-ack"},  
                description = "auto acknowledge, default true", required = false)
        private boolean acknowledge = true;
        
        @Parameter(names = { "--authPluginClassName", "-apc"},  
                description = "authPluginClassName setting", required = false)
        private String authPluginClassName; 
        
        @Parameter(names = { "--authParamsString", "-aps"},  
                description = "authParamsString setting", required = false)
        private String authParamsString; 
        
        @Parameter(names = { "--token", "-token"},  
                description = "token setting", required = false)
        private String token;
        
        @Parameter(names = { "--count", "-count"},  
                description = "consume message count", required = false)
        private int count = -1; 
        
        @Parameter(names = { "--help", "-h"},  
                description = "for a help", required = false)
        private boolean help;
    }
    
    public static void main(String[] args) {
        System.out.println("test jar version 1.0");
    	TestPulsar t = new TestPulsar();
    	JCommander jcommander = new JCommander(t);
        jcommander.setProgramName("pulsar-test");
        ProducerCmd p = t.new ProducerCmd();
        jcommander.addCommand("producers", p);
        ConsumerCmd c = t.new ConsumerCmd();
        jcommander.addCommand("consumers", c);
        jcommander.parse(args);
        
        if(t.help || p.help || c.help){
        	jcommander.usage();
        	System.exit(1);
        }
        
        if(!isEmpty(p.producer) && !isEmpty(c.consumer)){
        	System.err.println("you can only set producer or consumer!");
        	System.exit(1);
        }
        
        if(isEmpty(p.producer) && isEmpty(c.consumer)){
        	System.err.println("you can must set producer or consumer!");
        	System.exit(1);
        }
        
        if(!isEmpty(p.producer)){
        	if(isEmpty(p.brokerURL)){
        		jcommander.usage();
        		System.exit(1);
        	}
        	
        	if(isEmpty(p.topic)){
        		jcommander.usage();
        		System.exit(1);
        	}
        	
        	if(isEmpty(p.tenant)){
        		p.tenant = "public";
        	}
        	
        	if(isEmpty(p.namespace)){
        		p.namespace = "default";
        	}
        	
        	try {
				testProducer(p.brokerURL, p.tenant, p.namespace, p.topic, p.producer, p.count, p.listenerName, p.authPluginClassName, p.authParamsString, p.token);
			} catch (PulsarClientException e) {
				e.printStackTrace();
			}
        	System.out.println("====>>>> finished produce!!!!!, totalCount=" + p.count);
        	System.exit(1);
        }
        
        if(!isEmpty(c.consumer)){
        	if(isEmpty(c.brokerURL)){
        		jcommander.usage();
        		System.exit(1);
        	}
        	
        	if(isEmpty(c.topic)){
        		jcommander.usage();
        		System.exit(1);
        	}
        	
        	if(isEmpty(c.tenant)){
        		c.tenant = "public";
        	}
        	
        	if(isEmpty(c.namespace)){
        		c.namespace = "default";
        	}
        	
        	testConsumer(c.brokerURL, c.tenant, c.namespace, c.topic, c.consumer, c.listenerName, c.acknowledge, c.authPluginClassName, c.authParamsString, c.count, c.token);
        }
	}
    
    private static void testConsumer(String brokerUrl, String tenant, String namespace, String topic, 
    		String groupName, String listenerName, boolean acknowledge, String authPluginClassName, String authParamsString, int count, String token){
        try {
        	System.out.println("===>>> connecting [" + brokerUrl + "]...");
        	ClientBuilder clientBuilder = PulsarClient.builder().serviceUrl(brokerUrl);
            if( !isEmpty(listenerName)) {
                clientBuilder.listenerName(listenerName);
            }
            if (!isEmpty(token)) {
                clientBuilder.authentication(AuthenticationFactory.token(token));
            }
            if (!isEmpty(authPluginClassName) && !isEmpty(authParamsString)) {
                clientBuilder.authentication(authPluginClassName, authParamsString);
            }
            
            PulsarClient client = clientBuilder.build();
            Consumer<byte[]> consumer = client.newConsumer()
                                            .topic("persistent://" + tenant + "/" + namespace + "/" + topic)
                                            .subscriptionName(groupName).subscribe();
            System.out.println("===>>> create connected success!");
            
            int consumeCount = 0;
            while(true){
                if(count > 0 && consumeCount >= count) {
                    System.out.println("===>>> consume finished! count=" + consumeCount);
                    System.exit(1);
                }
                
                Message<byte[]> msg = consumer.receive(1, TimeUnit.SECONDS);
                if(msg == null){
                	System.out.println("===>>> no msg!");
                	continue;
                }
                consumeCount++;
                MessageId msgId = msg.getMessageId();
                String id = getMsgId(msgId);
                System.out.println("===>> receive msgId = [" + id + "], msg = [" + new String(msg.getData()) + "]");
                
                if(acknowledge){
                    consumer.acknowledge(msg);
                }
            }
        } catch (PulsarClientException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    private static String getMsgId(MessageId msg){
        String id = null;
        if(msg instanceof MessageIdImpl){
            MessageIdImpl m = (MessageIdImpl) msg;
            id = new StringBuilder().append(m.getLedgerId())
                            .append(":").append(m.getEntryId())
                            .append(":").append(m.getPartitionIndex()).toString();
        }else if(msg instanceof BatchMessageIdImpl){
            BatchMessageIdImpl m = (BatchMessageIdImpl) msg;
            id = new StringBuilder().append(m.getLedgerId())
                    .append(":").append(m.getEntryId())
                    .append(":").append(m.getPartitionIndex())
                    .append(":").append(m.getBatchIndex()).toString();
        }else if(msg instanceof TopicMessageIdImpl){
            TopicMessageIdImpl tm = (TopicMessageIdImpl) msg;
            if(tm.getInnerMessageId() instanceof MessageIdImpl){
                MessageIdImpl m = (MessageIdImpl) tm.getInnerMessageId();
                id = new StringBuilder().append(m.getLedgerId())
                                .append(":").append(m.getEntryId())
                                .append(":").append(m.getPartitionIndex()).toString();
            }else{
                id = tm.getInnerMessageId().toString();
            }
        }else{
            id = msg.toString();
        }
        return id;
    }
    
    private static void testProducer(String brokerUrl, String tenant, String namespace, String topic, 
            String groupName, int count, String listenerName, String authPluginClassName, String authParamsString, String token) throws PulsarClientException {
        System.out.println("===>>> connecting [" + brokerUrl + "]...");
        
        ClientBuilder clientBuilder = PulsarClient.builder().serviceUrl(brokerUrl);
        if (!isEmpty(listenerName)) {
            clientBuilder.listenerName(listenerName);
        }
        if (!isEmpty(token)) {
            clientBuilder.authentication(AuthenticationFactory.token(token));
        }
        if (!isEmpty(authPluginClassName) && !isEmpty(authParamsString)) {
            clientBuilder.authentication(authPluginClassName, authParamsString);
        }
        
        PulsarClient client = clientBuilder.build();
        Producer<byte[]> producer = client.newProducer()
                .topic("persistent://" + tenant +"/" + namespace + "/" + topic)
                .producerName(groupName).create();
        System.out.println("===>>> create connected success!");
        int i = 0;
        if(count < 0){
            count = 20;
        }
        while(i++<count){
            try {
                String msg = "i just a" + i + " testing!";
                long start = System.currentTimeMillis();
                MessageId msgId = producer.send(msg.getBytes());
                long tooks = System.currentTimeMillis() - start;
                
                if(msgId instanceof MessageIdImpl){
                    MessageIdImpl m = (MessageIdImpl) msgId;
                    System.out.println("send msg tooks (" + tooks + ") ms, result is [" + m.getLedgerId() + "," + m.getEntryId() + "," + m.getPartitionIndex() + "]");
                }else if(msgId instanceof BatchMessageIdImpl){
                    BatchMessageIdImpl m = (BatchMessageIdImpl) msgId;
                    System.out.println("send msg tooks (" + tooks + ") ms, result is [" + m.getLedgerId() + "," + m.getEntryId() + "," + m.getPartitionIndex() + "]");
                }else{
                    System.out.println("send msg tooks (" + tooks + ") ms, result is [" + msgId.toString() + "]");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            try {
                Thread.sleep(200);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        client.shutdown();
    }
    
    /**
     * 校验字符串是否为空
     * @param str null or 空字符串都归类为空
     * @return true:为空，false：不为空
     */
    public static boolean isEmpty(String str){
        if (str == null) {
            return true;
        }
        boolean flag = false;
        if (str.length() == 0 || str.trim().equals("")
                || str.trim().equals("null")) {
            flag = true;
        }
        return flag;
    }
}

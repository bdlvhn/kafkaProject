package com.example.chapter4;

import org.apache.kafka.clients.consumer.*;
import org.apache.kafka.common.TopicPartition;
import java.util.*;

public class FirstAppConsumer {
	private static String topicName = "first-app";
	public static void main(String[] args) {

		// KafkaConsumer에 필요한 설정
		Properties conf = new Properties();
		conf.setProperty("bootstrap.servers","localhost:9092");
		conf.setProperty("group.id","FirstAppConsumerGroup");
		conf.setProperty("enable.auto.commit","false");
		conf.setProperty("key.deserializer","org.apache.kafka.common.serialization.IntegerDeserializer");
		conf.setProperty("value.deserializer","org.apache.kafka.common.serialization.StringDeserializer");

		// 카프카 클러스터에 메세지를 수신(consume)하는 객체 생성
		Consumer<Integer, String> consumer = new KafkaConsumer<>(conf);

		// 구독(subscribe)하는 Topic 등록
		consumer.subscribe(Collections.singletonList(topicName));

		for (int count=0; count<300; count++) {
			// 메세지를 수신하여 콘솔에 표시
			ConsumerRecords<Integer, String> records = consumer.poll(1);
			for (ConsumerRecord<Integer, String> record: records) {
				String msgString = String.format("key:%d, value:%s", record.key(), record.value());
				System.out.println(msgString);

				// 처리가 완료된 메세지의 오프셋을 커밋
				TopicPartition tp = new TopicPartition(record.topic(), record.partition());
				OffsetAndMetadata oam = new OffsetAndMetadata(record.offset()+1);
				Map<TopicPartition,OffsetAndMetadata> commitInfo = Collections.singletonMap(tp,oam);
				consumer.commitSync(commitInfo);
			} try {
				Thread.sleep(1000);
			} catch (InterruptedException ex) {
				ex.printStackTrace();
			}
		}
		// KafkaConsumer를 닫고 종료
		consumer.close();
	}
}
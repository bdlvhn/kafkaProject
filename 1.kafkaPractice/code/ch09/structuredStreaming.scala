// 01. 단순 출력
// 데이터셋 생성
val reader = spark.readStream
val formatConfigured = reader.format("kafka")

val optionConfigured = formatConfigured.
    option("subscribe","tweet").
    option("kafka.bootstrap.servers","kafka-broker01:9092")

val tweetDS = optionConfigured.load
tweetDS.printSchema

// 1단계 : 트윗 관련 데이터 및 형변환
val selectedDS = tweetDS.
    selectExpr("CAST(value AS string) AS value_as_str").
    selectExpr("CAST(get_json_object(value_as_str, '$.retweeted_status.retweet_count') AS int) AS retweet_count",
               "CAST(get_json_object(value_as_str, '$.retweeted_status.favorite_count') AS int) AS favorite_count",
               "get_json_object(value_as_str, '$.retweeted_status.text') AS text")
selectedDS.printSchema

// 2단계 : 기준에 맞게 필터링
val filteredDS = selectedDS.filter("retweet_count >= 1000 AND favorite_count >= 1000")

// 3단계 : 결과 value로 가져옴
val resultDS = filteredDS.selectExpr("CONCAT('retweet_count=', retweet_count,', ','favorite_count=', favorite_count, ', ','text=', text) AS value")

// 출력 설정과 스트림 처리
val writer = resultDS.writeStream
val writerWithFormat = writer.format("kafka")

val writerWithOption = writerWithFormat.
    option("kafka.bootstrap.servers","kafka-broker01:9092").
    option("topic","processed-tweet")

val homeDir = sys.env("HOME")
val writerWithMetaDir = writerWithOption.
    option("checkpointLocation",s"$homeDir/.structured_streaming_meta/example1")

import org.apache.spark.sql.streaming.Trigger
val writerWithTrigger = writerWithMetaDir.trigger(Trigger.ProcessingTime("2 seconds"))
val writerWithOutputMode = writerWithTrigger.outputMode("append")

val streamingQuery = writerWithOutputMode.start
streamingQuery.stop

// 02. 집약 처리
val langDS = spark.readStream.format("kafka").
    option("subscribe","tweet").
    option("kafka.bootstrap.servers","kafka-broker01:9092").
    load.
    selectExpr("CAST(value AS string) AS value").
    selectExpr("get_json_object(value, '$.lang') AS lang")

import org.apache.spark.sql.functions.count
val groupedDS = langDS.groupBy("lang").agg(count("*") as "count")

val resultDS = groupedDS.selectExpr("CONCAT('lang=', lang, ' count=', count) AS value")

spark.conf.set("spark.sql.shuffle.partitions",10)
import org.apache.spark.sql.streaming.Trigger
val homeDir = sys.env("HOME")
val streamingQuery = resultDS.writeStream.format("kafka").
    option("topic","processed-tweet").
    option("kafka.bootstrap.servers","kafka-broker01:9092").
    option("checkpointLocation",s"$homeDir/.structured_streaming_meta/example2").
    trigger(Trigger.ProcessingTime("2 seconds")).
    outputMode("complete").
    start

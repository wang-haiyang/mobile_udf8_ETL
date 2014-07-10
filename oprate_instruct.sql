一、概述
对原始数据集mobile_utf8进行数据清洗，得到清洗后的数据mobile_gis,一份以hive表存储，一份以文件形式存于新的账户omnipublic下。

二、处理流程
1.抽取有效字段
2.去掉imsi为NULL的所有记录(不必纠结此举会对实验结果造成影响，当有影响时把那部分数据集插入mobile_gis即可。而且imsi为NULL的基本上packets，web_volume也为NULL，数据质量不高）
logt：基站经度
latt：基站纬度
tutc:开始时间戳，精确到毫秒
dutc:结束时间戳，精确到毫秒
三、步骤细化
1.处理后数据所含字段：

1	ttime(string)		请求开始时间,精确到秒，2012-08-17 10:32:31
2	tmsec(double)		请求开始时间的毫秒部分
3	dtime(string)		日志吐出时间，精确到秒，2012-08-17 10:35:52
4	dmsec(double)		日志突出事件的毫秒部分
5	lac(int)		locaion area code
6	ci(int)			cell id
7	imsi(int)		International mobile subscriber identity，用于唯一确定用户身份	
8	mobile_type(string)	移动代理的类型	
9	success(int)		是否请求成功，成功返回1
10	response_time(int)	请求响应时延	
11	content_length(bigint)	byte number of requested object	
12	uri_main(string)	host name
13	retransfer_count(int)	重传次数
14	packets(int)		传输的packet数
15	status_code(string)	HTTP Status Code	
16	web_volume(bigint)		byte number of transfered web object
17	user_agent(string)	HTTP user agent header	
18	content_type(string)	HTTP content type header	
19	dest_port(int)		目标端口
20	sub_category1(int)	Classification to different service providers, e.g. netease
21	category(string)	The TOP classification, e.g. video, music.		
22	uri(string)		URI of HTTP header
23	os(string)		客户端的操作系统
24	tutc(double)		ttime的UTC时间
25	dutc(double)		dtime的UTC时间	
26	logt(double)		基站的经度	
27	latt(double)		基站的纬度

2.时间处理（ttime，dtime）
0816(25.9GB，周四，10:00~11:40):	16-8月 -12 10.01.17.035 上午,16-8月 -12 10.05.02.525000 上午;	16-8月 -12 11.41.36.138 上午,16-8月 -12 11.45.07.288000 上午	
0817(9.6GB，周五,10:00~18:00):	17-AUG-12 10.00.32.613 AM,17-AUG-12 10.05.07.418000 AM;		17-AUG-12 06.30.04.300 PM,17-AUG-12 06.35.02.344000 PM
0819(21.5GB，周日,00:00~24:00):	19-AUG-12 12.00.38.254 AM,19-AUG-12 12.05.05.948000 AM;		19-AUG-12 01.12.27.422 AM,19-AUG-12 01.15.06.544000 AM; 	19-AUG-12 11.59.54.205 PM,20-AUG-12 12.30.10.600000 AM(指的是20号上午凌晨00.30.10.600000); 
0820(22.3GB，周一,00:00~24:00):	20-AUG-12 12.00.16.282 AM,20-AUG-12 12.05.10.318000 AM;		20-AUG-12 01.19.12.991 AM,20-AUG-12 01.20.09.913000 AM;		20-AUG-12 11.58.47.721 AM,20-AUG-12 12.00.09.358000 PM;		20-AUG-12 12.35.30.882 PM,20-AUG-12 12.40.07.504000 PM;		20-AUG-12 01.23.36.654 PM,20-AUG-12 01.25.03.565000 PM;		20-AUG-12 11.52.26.223 PM,21-AUG-12 12.40.07.162000 AM
0821(22.2GB，周二,00:00~24:00):	21-AUG-12 12.00.08.018 AM,21-AUG-12 12.05.03.043000 AM;		21-AUG-12 11.59.58.039 PM,22-AUG-12 12.05.05.313000 AM
0822(22.5GB，周三,00:00~24:00):	22-AUG-12 12.00.20.011 AM,22-AUG-12 12.05.04.374000 AM;		22-AUG-12 11.51.51.031 PM,23-AUG-12 12.20.02.933000 AM
0823(22.1GB，周四,00:00~24:00):	23-AUG-12 12.04.10.668 AM,23-AUG-12 12.05.21.059000 AM;		23-AUG-12 11.08.27.393 PM,24-AUG-12 03.55.04.537000 AM
0824(21.5GB，周五,00:00~24:00):	24-AUG-12 12.00.17.596 AM,24-AUG-12 12.05.06.519000 AM;		24-AUG-12 11.58.00.400 PM,25-AUG-12 12.05.43.118000 AM
0825(17.0GB，周六,00:00~24:00):	25-AUG-12 12.00.04.709 AM,25-AUG-12 12.05.02.261000 AM;		25-AUG-12 11.59.55.096 PM,26-AUG-12 12.06.17.686000 AM
0826(16.6GB，周日,00:00~24:00):	26-AUG-12 12.00.15.098 AM,26-AUG-12 12.05.04.573000 AM;		26-AUG-12 11.15.38.793 PM,26-AUG-12 11.20.08.757000 PM
0827(6.6GB，周一，00:00~12:00):	27-AUG-12 12.03.47.821 AM,27-AUG-12 12.05.02.538000 AM;		27-AUG-12 11.49.23.514 AM,27-AUG-12 11.50.12.560000 AM
0828(20.0GB，周二,00:00~24:00):	28-AUG-12 12.03.25.361 AM,28-AUG-12 12.04.58.208000 AM;		28-AUG-12 11.57.08.482 PM,29-AUG-12 12.40.07.557000 AM
1003(16.0GB，周三,00:00~24:00):	02-10月-12 12.00.47.264 上午,02-10月-12 12.05.00.877000 上午;	02-10月-12 01.23.56.312 上午,02-10月-12 01.25.01.340000 上午;	02-10月-12 12.33.08.188 下午,02-10月-12 12.35.47.925000 下午;	02-10月-12 01.51.11.181 下午,02-10月-12 01.54.19.201000 下午;	02-10月-12 04.12.31.003 下午,02-10月-12 04.14.40.676000 下午;	02-10月-12 11.47.00.470 下午,03-10月-12 12.44.40.239000 上午
1004(17.2GB，周四,00:00~24:00):	04-10月-12 12.00.40.532 上午,04-10月-12 12.05.04.943000 上午;	04-10月-12 11.59.55.924 下午,05-10月-12 12.04.22.146000 上午
1005(20.2GB，周五,00:00~24:00):	05-10月-12 12.00.25.818 上午,05-10月-12 12.05.03.273000 上午;	05-10月-12 11.59.46.655 下午,06-10月-12 12.19.43.713000 上午
1006(20.9GB，周六,00:00~24:00):	06-10月-12 12.00.12.217 上午,06-10月-12 12.05.07.990000 上午;	06-10月-12 11.53.54.970 下午,07-10月-12 12.24.34.750000 上午
1007(19.5GB，周日,00:00~20:30):	07-10月-12 12.00.26.411 上午,07-10月-12 12.05.01.456000 上午;	07-10月-12 08.18.53.526 下午,07-10月-12 08.19.59.928000 下午
1010(24.7GB，周三,00:00~24:00):	10-10月-12 12.00.34.069 上午,10-10月-12 12.05.06.567000 上午;	10-10月-12 11.59.56.497 下午,11-10月-12 12.05.10.512000 上午
1013(21.0GB，周六,00:00~24:00):	13-10月-12 12.01.42.601 上午,13-10月-12 12.05.04.134000 上午;	13-10月-12 11.59.38.321 下午,14-10月-12 12.05.23.796000 上午


四、HQL代码
1.去掉所有imsi不为空的1~23字段
总共抽取21个字段，每个imsi码含16个字符
去掉imsi为空的记录
create table mobile_ectract as select ttime,dtime,lac,ci,imsi,mobile_type,success,response_time,content_length,uri_main,retransfer_count,packets,status_code,web_volume,user_agent,content_type,dest_port,sub_category1,category,uri,os from mobile_utf8
insert overwrite table mobile_ectract select * from mobile_ectract where imsi is not null;
2.使用udf.py把时间进行处理
处理后共23个字段，增加了tmsec,dmsec
若查询结果中某字段显示NULL,使用“where success is null”则能查到
add file udf.py;
create table mobile_deal as select  transform(*) USING 'python udf.py' AS(ttime,tmsec,dtime,dmsec,lac,ci,imsi,mobile_type,success,response_time,content_length,uri_main,retransfer_count,packets,status_code,web_volume,user_agent,content_type,dest_port,sub_category1,category,uri,os) from mobile_ectract;
alter table mobile_deal change column dmsec dmsec int;
3.增加tutc,dutc两个字段
处理后25个字段
unix_timestamp()处理后的utc时间精确到s，共10位
这2个字段精确到ms，共13位
如果string改为int显示NULL可尝试改成bigint
create table mobile_utc as select ttime,tmsec,dtime,dmsec,lac,ci,imsi,mobile_type,success,response_time,content_length,uri_main,retransfer_count,packets,status_code,web_volume,user_agent,content_type,dest_port,sub_category1,category,uri,os,unix_timestamp(ttime)*1000+tmsec as tutc,unix_timestamp(dtime)*1000+dmsec as dutc from mobile_deal;
alter table mobile_utc change column dmsec dmsec string;
alter table mobile_utc change column dutc dutc string;
4.与hz_gis表连接查询，增加logt，latt两个字段
create table mobile_gis as select m.*,h.logt,h.latt from mobile_utc m join hz_gis h on m.lac=h.lac and m.ci=h.ci;
5.把mobile_gis表的数据先存到本地文件系统
insert overwrite local directory '/mnt/sdc/mobile_gis' ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' SELECT * FROM mobile_test;
hadoop fs -put ./* /user/omnipub/mobile_gis     /*linux命令，把本地文件系统中的数据copy到HDFS上*/


五、对数据集的一些统计
（一）基站地理信息数据集
存储形式：hive表，名称：hz_gis
把用minigos爬取的原始数据去掉温州数据之后剩余的杭州数据
总行数：30914，共30914个基站数
（二）原始数据集
存储形式：hive表，名称：mobile_utf8
总行数：914583114
总基站数：42339（包括杭州的和温州的）
（三）mobile_ectract数据集
总行数：907552419
（四）mobile_deal数据集
总行数：907552419
（五）mobile_utc数据集
总行数：907552419
（六）mobile_gis数据集
总行数：890681124
总用户数：1874239
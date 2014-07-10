# -*- coding: utf-8 -*-
import sys
import os

def transtime(time):
  #把time按空格分开，共3个字段
   time = time.split(' ')
   if len(time) == 4:
     tyear = '20' + time[1].strip('-')
     tm_d = time[0].strip('月').split('-')
     tmonth  = tm_d[1]
     if len(tmonth) == 1:
       tmonth = '0' + tmonth
     pass
     tday = tm_d[0]
     if len(tday) == 1:
       tday = '0' + tday
     pass
     t_hmsms = time[2].split('.')
     thour = t_hmsms[0]
     tmin = t_hmsms[1]
     tsec = t_hmsms[2]
     tmsec = t_hmsms[3]
     if len(tmsec) == 6:
        tmsec = tmsec[:-3]
     pass
     #专门处理上午12和下午12
     if thour == '12':
       if time[3] == '上午' or time[3] == 'AM':
         thour = '00'
       elif time[3] == '下午' or time[3] == 'PM':
            pass
     elif time[3] == '下午' or time[3] == 'PM':
         thour = int(thour) + 12
         thour = str(thour)
     pass

   if len(time) == 3:
     tyear = '20' + time[0].split('-')[2]
     if time[0].split('-')[1] == 'AUG' or time[0].split('-')[1] == '8月':
       tmonth = '08'
     pass
     if time[0].split('-')[1] == 'OCT' or time[0].split('-')[1] == '10月':
       tmonth = '10'
     pass
     tday = time[0].split('-')[0]
     if len(tday) == 1:
       tday = '0' + tday
     pass
     t_hmsms = time[1].split('.')
     thour = t_hmsms[0]
     tmin = t_hmsms[1]
     tsec = t_hmsms[2]
     tmsec = t_hmsms[3]
     if len(tmsec) == 6:
        tmsec = tmsec[:-3]
     pass
     #专门处理上午12和下午12
     if thour == '12':
       if time[2] == '上午' or time[2] == 'AM':
         thour = '00'
       elif time[2] == '下午' or time[2] == 'PM':
            pass
     elif time[2] == '下午' or time[2] == 'PM':
         thour = int(thour) + 12
         thour = str(thour)
     pass
   pass

   time_trans = tyear + '-' + tmonth + '-' + tday + ' ' + thour + ':' + tmin + ':' + tsec + '\t' + tmsec
   return time_trans 
pass


#对每一行做如下处理
for line in sys.stdin:
  #通过'\t'分割成21个字段，每个line[i]包含一个字段
   line = line.split('\t')
   ttime = line[0]
   dtime = line[1]
   #解析ttime，解析后包含两个字段，标准格式的时间和毫秒，之间以'\t'分割
   ttime_trs = transtime(ttime)
   #if len(dtime) <  20:
      #continue
   if dtime.find("-12") < 0:
      dtime_trs = '' + '\t' + ''
   #解析dtime，解析后包含两个字段，标准格式的时间和毫秒，之间以'\t'分割
   else:
      dtime_trs = transtime(dtime)
   #输出解析完毕的ttime和dtime，总共4个字段       
   print ttime_trs + '\t' + dtime_trs + '\t',
   #输出其他的字段，range是左闭右开区间
   for i in range(2,len(line)):
     if i !=len(line)-1 :
       print line[i] + '\t',
     pass
     if i == len(line) -1:
       print line[i],
     pass
   pass
pass

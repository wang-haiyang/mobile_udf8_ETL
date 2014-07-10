import os
import sys

for line in sys.stdin:
   line = line.split('\t')
   ttime = line[0]
   dtime = line[1]
   print ttime + '\t' + dtime + '\t' + line[2] + '\t' + line[3]
pass

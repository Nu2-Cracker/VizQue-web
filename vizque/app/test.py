
import sys
import json
sys.path.append("/VizQue/vizque/app/nimlibs")
import nowtime
s = nowtime.nowtime()
a = dir(s['timezone'])
print(str(s['timezone']))
print(type(str(s['timezone'])))



#実行時test用
#ファイルサイズ
import sys
import json
sys.path.append("/VizQue/vizque/app/nimlibs")
# import nowtime
# s = nowtime.nowtime()
# a = dir(s['timezone'])
# print(str(s['timezone']))
# print(type(str(s['timezone'])))
import vizque
import os



print(dir(vizque))
vizque.run_vizque("イヌザメ")
print("ファイルサイズ", os.path.getsize("/VizQue/react-app/jsonData/graph.json"))
vizque.run_vizque("オオメジロザメ")
print("ファイルサイズ", os.path.getsize("/VizQue/react-app/jsonData/graph.json"))

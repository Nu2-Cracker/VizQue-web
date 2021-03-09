import os,
 times,
 nimpy


proc nowtime(): string {.exportpy.} = 
  #今日の日時と日付を表示
  let t = now()
  let nowStr: string = format(t, "yyyy/MM/dd HH:mm:ss")
  return nowStr


# nim c --threads:on --app:lib --out:nowtime.so nowtime
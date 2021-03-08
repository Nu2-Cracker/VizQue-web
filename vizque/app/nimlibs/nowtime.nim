import os,
 times,
 nimpy


proc nowtime(): string {.exportpy.} = 
  let t = now()
  let nowStr: string = format(t, "yyyy/MM/dd HH:mm:ss")
  return nowStr


# nim c --threads:on --app:lib --out:nowtime.so nowtime
import os,
 times,
 nimpy


proc nowtime(): DateTime {.exportpy.} = 
  let t = now()
  return t


# nim c --threads:on --app:lib --out:nowtime.so nowtime
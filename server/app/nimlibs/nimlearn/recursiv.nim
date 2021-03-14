

var limit: int = 5
var t = 0
var querys: seq[string] = @["西アフリカ 国", "西アフリカ ドレス", "西アフリカ 地図", "西アフリカ 英語", "西アフリカ 民族衣装", "西アフリカ スモーキー", "西アフリカ 布", "西アフリカ マリ", "ニシアフリカトカゲモドキ"]


proc searchmodel(query: string): seq[string]=
  var qs = newSeq[string]()
  for i in 1..3:
    var newquery = query & " " & $i
    qs.add(newquery)
  return qs


echo querys
echo "###########"
# let ser = searchmodel(querys[3])


proc recursive(querys):
  for q in querys:
    let ser = searchmodel(q)
    echo ser
    echo "$$$$$$$$$$$$$$$$$$$"


proc joker(n: int): int =
  var ss = (n / 2)
  echo ss
  if n > limit:
    return n
  return joker(n+1)


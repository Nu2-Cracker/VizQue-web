# nim c -o:output_vizque -r vizque.nim
#python にすると追記になる
import
  httpClient,
  strtabs,
  re,
  xmlparser,
  xmltree,
  tables,
  strutils,
  JSON,
  nimpy


type
  QueryDatas = Table[string, string]
  SecTables = seq[QueryDatas]

type
  GraphDatas = ref object
    nodes: SecTables
    edges: SecTables



var
  node: QueryDatas = initTable[string, string]()
  node_init = node
  edge: QueryDatas = initTable[string, string]()
  edge_init = edge
  graph = initTable[string, SecTables]()
  # querylist: seq[string] = newSeq[string]()
  #Node
  node_id: int = 0
  node_permission = true
  #edge
  from_id: int = 0
  to_id: int = 0

#オブジェクト定義
var G:GraphDatas = new GraphDatas



proc create_node(query: string, node_id: int) =
  #queryからnodeを作成する

  #ノードの作成
  node["id"] = $node_id
  node["label"] = query
  node["url"] = "https://www.google.com/search?q=${query}" % {"query": query}.newStringTable
  #nodesに格納
  G.nodes.add(node)
  #ノードの初期化
  node = node_init


proc create_edge(from_id: int, to_id: int) =
  #queryからedgeを作成する
  edge["from"] = $from_id
  edge["to"] = $to_id
  #edgesに格納
  G.edges.add(edge)
  #edgeの初期化
  edge = edge_init



#no use



proc check_label(query: string, node:SecTables ): int =
  #既存のlabelと一致するかチェック=>一致する場合,
  #to_id=既存のid, no=> to_id=現在のid+1を返す
  for n in node:
    if query == n["label"]:
      node_permission = false #Nodeは作成しない
      return parseInt(n["id"])

  inc(node_id)
  return node_id



proc querygetter(query: string): seq[string] =
  #検索結果を格納するsequence
  var searchQuery = newSeq[string]()
  #空白を埋めてget用URLの作成
  var rep_query = query.replace(re"\s+", "%20")
  var url = "http://www.google.com/complete/search?hl=en&q=${query}&output=toolbar" % {"query": rep_query}.newStringTable

  # httpクライエントの作成
  let client = newHttpClient()
  let response = client.request(url)
  #bodyを取得
  var body: string = response.body
  #xmlをパース
  let xmls = parseXml(body)
  #suggestion タグの取得
  var tag_suggestion = xmls.findAll("suggestion")
  tag_suggestion = tag_suggestion[1..^1] #頭はqueryなので含まない

  var graph_data = G.nodes #G.nodesをdeep copy

  for tag in tag_suggestion:
    let relationQuery = tag.attr("data") #tagからdata属性(関連キーワード)を取得

    to_id = check_label(relationQuery, graph_data) #既存のlabelと一致するかチェック
    if node_permission:
      create_node(relationQuery, to_id) #trueならrelationqueryからnodeを作成
    #from_idをfrom_id, to_idをto_idとしてedgeを作成
    create_edge(from_id, to_id)

    searchQuery.add(relationQuery)
    node_permission = true #初期化

  return searchQuery #検索クエリ候補を返す


proc createGraph_SearchQuery(reader: string): seq[string]=
  #from側のidをセット
  from_id = node_id

  var querys: seq[string] = querygetter(reader)


  for query in querys:
    #from_idは、G.nodesのラベルとqueryが一致するものの
    #idを使用
    #ここの処理でメモリーエラー起こしてるっぽいね
    var graph_data = G.nodes #G.nodesをdeep copy
    for n in graph_data:
      if n["label"] == query:
        from_id = parseInt(n["id"])
        var _ = querygetter(query)

  # queryはオブジェクト定義してオブジェクトに入れる方がいいかも
  result=querys


#再起で書いてループ回数を指定するようにするか

proc run_vizque(reader: string, level: string): string {.exportpy.} =

  G = new GraphDatas #初期化
  var l: string = level
  if l == "":
    l = "2"
  create_node(reader, node_id)

  var querys = createGraph_SearchQuery(reader)

  var i=2

  while i < parseInt(l):
    var query_sets = newSeq[string]()
    for i in querys:
      let q = createGraph_SearchQuery(i)
      if len(q) != 0:
        for j in q:
          if j notin query_sets:
            query_sets.add(j)
    querys = query_sets
    inc i

  graph["nodes"] = G.nodes
  graph["edges"] = G.edges
  let to_json = %* graph
  var jsonData: string = to_json.pretty(indent=5)
  return jsonData


# let data = run_vizque("cpp metaprogramming", "")


#test用
#内容
# インスタンスの初期化

# nim c -r -o:/vizque ./vizque.nim
# nim c --threads:on --app:lib --out:vizque.so vizque





import
  httpClient,
  strtabs,
  re,
  xmlparser,
  xmltree,
  tables,
  strutils,
  JSON,
  nimpy,
  algorithm


type
  QueryDatas = Table[string, string]
  SecTables = seq[QueryDatas]

type
  GraphDatas = ref object
    nodes: SecTables
    edges: SecTables

type
  ParentNode = ref object
    setn: QueryDatas

var
  graph = initTable[string, SecTables]()
  #Node
  node_id: int = 0

#オブジェクト定義
var G:GraphDatas = new GraphDatas
var Pnode: ParentNode = new ParentNode

var searched: seq[string];

proc `is`(a: string, b: string): bool =
    return a == b

proc `empty`(a:seq): bool =
  if a.len == 0:
    return true



proc create_node(query: string, node_id: int): QueryDatas =
  #queryからnodeを作成する
  var node: QueryDatas = initTable[string, string]()
  #[
    既にnodeが存在する場合は、既存のnodeの追加はせず、既存のnodeを返す
  ]#

  for n in G.nodes:
    if n["label"] == query:
      return n


  #ノードの作成
  node["id"] = $node_id
  node["label"] = query
  node["url"] = "https://www.google.com/search?q=${query}" % {"query": query}.newStringTable
  #nodesに格納
  G.nodes.add(node)

  return node



proc create_edge(to_id: string) =
  #queryからedgeを作成する
  var edge: QueryDatas = initTable[string, string]()

  edge["from"] = Pnode.setn["id"]
  edge["to"] = to_id
  #edgesに格納
  G.edges.add(edge)

proc queryGetter(query: string): seq[string] =
  result=newSeq[string]()

  #このクエリで検索をかける
  var rep_query = query.replace(re"\s+", "%20")
  #google先生に怒られた時はwikipedia(en)からとってくる
  #jaとenを選べるようにしようか
  # https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=killer%20whale

  # var url = "http://suggestqueries.google.com/complete/search?output=toolbar&hl=ja&q=${query}" % {"query": rep_query}.newStringTable
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


  for tag in tag_suggestion:
    let relationQuery = tag.attr("data") #tagからdata属性(関連キーワード)を取得
    if relationQuery is query: #queryと同じならスキップ
      continue
    result.add(relationQuery)


proc setParentNode(query:string) =
  let pnode = create_node(query, node_id)
  Pnode.setn = pnode




#スタート
#queryから元のノードを作成
proc run_vizque(reader: string, level: string): string {.exportpy.} =
  G = new GraphDatas #初期化
  var level: string;
  if level is "":
    level = "5" #デフォルト値
  var querys: seq[string] = @[reader]

  let selectLevel: int = parseInt(level) #多くても100とかに制限しようかな
  var levelTicket:int = 1
  while true:
    if empty(querys) or levelTicket > selectLevel:
      break

    querys.reverse()
    var query = pop querys
    querys.reverse()
    setParentNode(query) #親ノードの設定
    inc node_id

    searched = queryGetter(query)
    inc levelTicket
    for q in searched:
      let chiled = create_node(q, node_id) #子ノードの設定
      inc node_id
      let to_id: string = chiled["id"]
      create_edge(to_id)
      querys.add(q)

  graph["nodes"] = G.nodes
  graph["edges"] = G.edges
  let to_json = %* graph
  result= to_json.pretty(indent=5)







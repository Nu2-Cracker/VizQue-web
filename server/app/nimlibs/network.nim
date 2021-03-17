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
  node_permission = true

#オブジェクト定義
var G:GraphDatas = new GraphDatas
var Pnode: ParentNode = new ParentNode

var searched: seq[string];

proc `is`(a: string, b: string): bool =
    return a == b

proc `empty`(a:seq): bool =
  if a.len == 0:
    return true

proc `**`(a:seq, b:string): bool =
  if b notin a:
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
  echo body
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

var querys: seq[string] = @["python"]

const selectLebel: int = 5 #多くても100とかに制限しようかな
var levelTicket:int = 1
while true:

  if empty(querys) or levelTicket > selectLebel:
    break
  #[
    反転させてからpopで取り出して元に戻す

    循環するケースがありそうだな。
    循環を脱出するケースを作る必要がある
  ]#
  echo "関係キーワード数: " ,  querys.len
  echo "階層数: ", levelTicket
  # echo querys
  querys.reverse()
  var query = pop querys
  echo "現在のキーワード数 (親): ", query
  querys.reverse()


  setParentNode(query)
  inc node_id


  searched = queryGetter(query)
  inc levelTicket
  for q in searched:

    let chiled = create_node(q, node_id)
    inc node_id

    let to_id: string = chiled["id"]
    create_edge(to_id)

    #querysに追加
    querys.add(q)




graph["nodes"] = G.nodes
graph["edges"] = G.edges
let to_json = %* graph
var jsonData: string = to_json.pretty(indent=5)

# echo jsonData


# echo Pnode.setn
# echo searched
# このsearchedとParentNodeからnode-edge-queryの関係を作る



# for q in searched:
#   # まずここでかな。
#   # 既存のノードに既にqが含まれているかチェック
#   #含まれているならdgeのfromidを既存のノードのidにする
#   #新規にノード追加は行わない <=これはcreate_node内で行おう
#   #[
#     create_node内で行えば、chiledで既存のnodeを返すことも可能かつ毎回変更かつGCで前の値は
#     捨てられるので副作用は少ないはず
#   ]#
#   let chiled = create_node(q, node_id)
#   let to_id: string = chiled["id"]
#   create_edge(to_id)
#   inc node_id #追加するとidを1増やす

#[
  edgeとの接続はfoでおこなうが時点でのparent nodeの決定はsearchedからpopで返す
]#




#[
  unhandled exception: unknown_xml_doc(1, 263) Error: '"' or "'" expected [XmlError]
  これはレスポンス大量のペナルティ
]#






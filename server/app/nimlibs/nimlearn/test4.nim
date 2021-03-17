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
#closur iterator
#[
    python javascript でまずclosureのメリットを調べてみてもいいかも
]#

#nim closure
#[
    nim でclosureの実装
    nimpyはclosureはだめだけどiteratorなら呼び出せそう
]#
# iterator numbers10(): int {.exportpy.} =
#     var i = 0
#     while i <= 10:
#         yield i
#         inc i

# type
#   QueryDatas = Table[string, string]
#   SecTables = seq[QueryDatas]

# type
#   GraphDatas = ref object
#     nodes: SecTables
#     edges: SecTables


# proc `@`(a: string): int =
#     let p = parseInt(a)
#     return p


# let strNum: string = "45"


# echo high("hello")
# echo  @strNum


# var result=""
# for i in 'a'..'z':
#     result.add(i)

# echo result


proc `is`(a: string, b: string): bool =
    return a == b

proc `empty`(a:seq): bool =
    if a.len == 0:
         return true
# let s = "Hello"
# let m = "Hello"

# echo s is m

proc testproc(): seq[string] =
    result = newSeq[string]()
    let query = "pop"

    let tag_suggestion = @["orage", "mikan", "pop"]
    for tag in tag_suggestion:
        if tag is query:
            continue
        result.add(tag)

let r = testproc()


var tag_suggestion = @["orage", "mikan", "pop"]


# var s: string;
# while true:
#     if empty tag_suggestion:
#         tag_suggestion.add("お化け")
#         tag_suggestion.add("みかん")
#         tag_suggestion.add("お化け")
#         echo tag_suggestion
#         break
#     s = pop tag_suggestion
#     tag_suggestion.add("お化け")
#     echo tag_suggestion
#     s = pop tag_suggestion

# nim c --threads:on --app:lib --out:test4.so test4
#[
x=`find . -perm /u=x,g=x,o=x -type f` && \
rm $x
]#


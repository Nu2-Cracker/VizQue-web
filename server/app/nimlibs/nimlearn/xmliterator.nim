#[
    そもそもiteratorで関数を返せる??
]#
import
    nimpy,
    httpClient,
    strtabs,
    re

iterator getURL: string =
    var testcase: seq[string] = @["orange","mikan","wolf","cat","dog"]

    for q in testcase:
        var rep_query = q.replace(re"\s+", "%20")
        var url = "http://www.google.com/complete/search?hl=en&q=${query}&output=toolbar" % {"query": rep_query}.newStringTable
        yield url

proc requestxml(url: string) : string=
    let client = newHttpClient()
    let response = client.request(url)
    let body: string  = response.body
    return body



iterator getxmliterator():string {.exportpy.} =  
    for url in getURL():
        let body = requestxml(url)
        yield body


    


# nim c -r xmliterator.nim
# nim c --threads:on --app:lib --out:xmliterator.so xmliterator






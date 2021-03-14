
#iteraotr generatorの実装

# pairs iterator
type 
    CustomRange = object
        low: int
        high: int


iterator items(range: CustomRange): int = 
    #[
        3, 6なら3から6を出力
    ]#
    var i = range.low
    while  i <= range.high:
        yield i
        inc i
        
iterator  pairs(range: CustomRange): tuple[a: int, b: char] = 
    for i in range:
        yield (i, char(i + ord('a')))



for i, j in CustomRange(low: 3, high: 10):
    echo i, " ", j #tupleは返せない??

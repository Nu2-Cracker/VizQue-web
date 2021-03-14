import nimpy
#closur iterator
#[
    python javascript でまずclosureのメリットを調べてみてもいいかも
]#

#nim closure
#[
    nim でclosureの実装
    nimpyはclosureはだめだけどiteratorなら呼び出せそう
]#
iterator numbers10(): int {.exportpy.} = 
    var i = 0
    while i <= 10:
        yield i
        inc i


# nim c --threads:on --app:lib --out:test4.so test4
#[
x=`find . -perm /u=x,g=x,o=x -type f` && \
rm $x
]#
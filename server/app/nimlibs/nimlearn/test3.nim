
iterator  `...`*[K](a: K, b: K): K =
    var res: K = K(a)
    while  a <=  b:
        yield res
        inc res

for i in 3..5:
    echo i
        

# # Give it a different name to avoid conflict
# iterator `...`*[T](a: T, b: T): T =
#   var res: T = T(a)
#   while res <= b:
#     yield res
#     inc res

# for i in 0...5:
#   echo i
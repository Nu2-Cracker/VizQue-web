#python closure learnning

def print_msg(msg):

    def printer():
        print(msg)
    return printer

another = print_msg("Hello")
another()

print("&&&&&&&&&&&&&&")

def make_multiplier(n):
    def multiplier(x):
        return x * n
    return multiplier

times = make_multiplier(4)
print("6 x 4 = ",times(6))
print("&&&&&&&&&&&&&&")

s = make_multiplier.__closure__
l = times.__closure__
print(s)
print(l[0].cell_contents)
print(l[0].cell_contents)
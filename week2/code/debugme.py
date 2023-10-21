def buggyfunc(x):
    y = x
    for i in range(x):
        import ipdb; ipdb.set_trace()
        y = y-1
        z = x/y
    return z

buggyfunc(20)
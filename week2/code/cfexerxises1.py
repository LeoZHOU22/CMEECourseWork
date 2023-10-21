def foo_1():
    x = float(input("Enter a number for square root calculation: "))
    return x ** 0.5

def foo_2():
    x = float(input("Enter the first number: "))
    y = float(input("Enter the second number: "))
    if x > y:
        return x
    return y

def foo_3():
    x = float(input("Enter the first number: "))
    y = float(input("Enter the second number: "))
    z = float(input("Enter the third number: "))
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4():
    x = int(input("Enter a number for factorial calculation (using for loop): "))
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(): 
    x = int(input("Enter a number for factorial calculation (using recursion): "))
    if x == 0:
        return 1
    elif x == 1:
        return 1
    else:
        return x * foo_5(x - 1)

def foo_6(): 
    x = int(input("Enter a number for factorial calculation (using while loop): "))
    if x == 0:
        return 1
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto


def main():
    print("Result of foo_1:", foo_1())
    print("Result of foo_2:", foo_2())
    print("Result of foo_3:", foo_3())
    print("Result of foo_4:", foo_4())
    print("Result of foo_5:", foo_5())
    print("Result of foo_6:", foo_6())

if __name__ == "__main__":
    main()

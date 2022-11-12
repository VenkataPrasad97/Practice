given_str=input("Enter the string: * and # only")
def given_string(str1):
    a=0
    b=0
    for i in str1:
        if i=='*':
            a+=1
        elif i=='#':
            b+=1
        else:
            print("Invalid Input")
            break
    return(a-b)
print(given_string(given_str))





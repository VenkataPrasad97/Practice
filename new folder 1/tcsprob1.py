num=int(input("Enter the size of array:"))
arr=[]
a,x=0,0
print("Enter elements one by one:")
for i in range(num):
    a=int(input())
    arr.append(a)
#Value of first 
first_value=arr[0]
for i in range(num):
    if first_value<=arr[i]:
        x+=1
print("Count of values greater than first element:",x)
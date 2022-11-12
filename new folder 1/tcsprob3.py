n=int(input("Enter number of balloons:"))
#how to get only positive values?
print("Enter the color one by one and only use (V,I,B,G,Y,O,R) or (v,i,b,g,y,o,r)")
a=[]
v,i,b,g,y,o,r=0,0,0,0,0,0,0
for z in range(n):
    m=input()
    a.append(m)
for x in a:
    if x=="v":
        v+=1
    elif x=="i":
        i+=1
    elif x=="b":
        b+=1
    elif x=="g":
        g+=1
    elif x=="y":
        y+=1
    elif x=="o":
        o+=1
    elif x=="r":
        r+=1
    else:
        print("Invalid input")
print("VIBGYOR:",v,i,b,g,y,o,r)
b=[v,i,b,g,y,o,r]
c=['v','i','b','g','y','o','r']
for j in range(7):
    if b[j]==0:
        print(j)
        continue
    if b[j]%2==1:
        print(j)
        print("Color balloon present odd number of times in the bunch",c[j])
        break
    else:
        print(j)
        pass

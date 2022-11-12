enter=[]
leave=[]
guest_present=[]
x,y,z=0,0,0
a=int(input("Enter the number of hours:"))
for i in range(a):
    x=int(input("Entry:"))
    y=int(input("Exit:"))
    enter.append(x)
    leave.append(y)
    z+=x-y
    guest_present.append(z)
print(max(guest_present))

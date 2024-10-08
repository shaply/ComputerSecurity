with open("PCusers.txt") as file:
  allLines=file.read().split("\n")
  admins=[]
  users=[]
  which="administrators"

  for row in allLines:
    if "password" not in row.lower():
        if "users" in row.lower():
          which="users"
        if which == "administrators":
          if " " in row:
            row=row.split()[0]
          admins.append(row)
        if which=="users":
          users.append(row)
  allusers=admins+users

  #Doesn't delete users from sudo group yet
  import os
  os.chdir("/home")
  allUser=os.listdir()
  for user in allUser:
    if user not in allusers:
      os.system("userdel %s"%(user))

with open("/etc/group") as file:
  d = file.readline()
  while "sudo" not in d:
    d=file.readline()

print("users", users)
d=d[:-1]
splitted=d.split(":")
usersInSudo=splitted[3].split(",")
print(usersInSudo)
for user in usersInSudo:
  if user in users:
    os.system("gpasswd -d %s sudo"%(user))
    pass

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
  print(admins, users)

  #Doesn't delete users from sudo group yet
  import os
  os.chdir("/home")
  users=os.listdir()
  for user in users:
    if user not in allusers:
      os.system("userdel %s"%(user))

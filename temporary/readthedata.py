import csv

with open('filedata.csv') as datareader:
  readss = csv.reader(datareader,delimiter=',')
  data=list(readss)

dateChanged={}
dateModify={}
headers=data.pop(0)

for file in data:
  #Add files in groups to the dateChanged
  try:
    if file[1].split()[0] in dateChanged:
      dateChanged[file[1].split()[0]].append([file[0],file[1].split()[1]])
    else:
      dateChanged[file[1].split()[0]]=[]
      dateChanged[file[1].split()[0]].append([file[0],file[1].split()[1]])
  except:
    pass
  #Add files in groups to the dateModify
  try:
    if file[2].split()[0] in dateModify:
      dateModify[file[2].split()[0]].append([file[0], file[2].split()[1]])
    else:
      dateModify[file[2].split()[0]]=[]
      dateModify[file[2].split()[0]].append([file[0], file[2].split()[1]])
  except:
    pass

ques="asdfghjkl;"
currDirectory = "/"
while ques.lower()!="done":
  try:
    if ques.lower()=="changed date list":
      for date in sorted(dateChanged):
        length = 0
        for f in dateChanged[date]:
          if currDirectory in f:
            length += 1
        print(date+': '+str(length))

    elif ques.lower()=="modified date list":
      for date in sorted(dateModify):
        print(date+': '+str(len(dateModify[date])))

    elif ques.lower()=="datemodify":
      ques2=input("Which modified date(EX| 2020-04-29)? ")
      for file in dateModify[ques2]:
        if currDirectory in file:
          print(file[0],file[1])

    elif ques.lower()=="datechanged":
      ques2=input("Which changed date(EX| 2020-04-29)? ")
      for file in dateChanged[ques2]:
        if currDirectory in file:
          print(file[0],file[1])
    elif ques.lower()=="change directory":
      ques2=input("Which directory do you want to only read from(EX| /etc)?")
      currDirectory = ques2
      
    else:
      if 'path' in ques.lower() and 'filename' in ques.lower():
        ques=input("What is the path and filename(EX| /home/John/hi.txt) or for contents in path(EX| /home/John/)? ")
      for file in data:
        if file[0] in ques or ques in file[0]:
          print("%s, 'ChangedDate:%s', 'ModifiedDate:%s'"%(file[0],file[1],file[2]))
          if ques[-1]!="/":
            break
  except Exception as e:
    print(e)

  print("\nchanged date list, datechanged, modified date list, datemodify, 'path + filename', date grouper, change directory, done")
  print("Current directory is " + currDirectory)
  ques=input("What is it you wanna do? ")

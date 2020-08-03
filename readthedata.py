import csv

with open('filedata.csv') as datareader:
  readss = csv.reader(datareader,delimiter=',')
  data=list(readss)

dateChanged={}
dateModify={}
headers=data.pop(0)

for file in data:
    #Add files in groups to the dateChanged
    if file[1].split()[0] in dateChanged:
      dateChanged[file[1].split()[0]].append([file[0],file[1].split()[1]])
    else:
      dateChanged[file[1].split()[0]]=[]
      dateChanged[file[1].split()[0]].append([file[0],file[1].split()[1]])

    #Add files in groups to the dateModify
    if file[2].split()[0] in dateModify:
      dateModify[file[2].split()[0]].append([file[0], file[2].split()[1]])
    else:
      dateModify[file[2].split()[0]]=[]
      dateModify[file[2].split()[0]].append([file[0], file[2].split()[1]])

ques="asdfghjkl;"
while ques.lower()!="done":
  if ques.lower()=="changed date list":
    for date in sorted(dateChanged):
      print(date+': '+str(len(dateChanged[date])))
  
  elif ques.lower()=="modified date list":
    for date in sorted(dateModify):
      print(date+': '+str(len(dateModify[date])))
  
  elif ques.lower()=="datemodify":
    ques2=input("Which modified date(EX| 2020-04-29)? ")
    for file in dateModify[ques2]:
      print(file[0],file[1])

  elif ques.lower()=="datechanged":
    ques2=input("Which changed date(EX| 2020-04-29)? ")
    for file in dateChanged[ques2]:
      print(file[0],file[1])

  else:
    if 'path' in ques.lower() and 'filename' in ques.lower():
      ques=input("What is the path and filename(EX| /home/John/hi.txt) or for contents in path(EX| /home/John/)? ")
    for file in data:
      if file[0] in ques or ques in file[0]:
        print("%s, 'ChangedDate:%s', 'ModifiedDate:%s'"%(file[0],file[1],file[2]))
        if ques[-1]!="/":
          break

  print("\nchanged date list, datechanged, modified date list, datemodify, 'path + filename', date grouper, done")
  ques=input("What is it you wanna do? ")

import os
import subprocess
import sys

#output = subprocess.check_output("", shell=True)
#os.chdir()     Changes directory
#os.getcwd()    Gets current directory
#os.listdir()    Lists all files/folders in directory
#[filename]

sys.setrecursionlimit(2000)

#List all files and folders
def listdir():
  import os

  files=os.listdir()
  folderN=[]
  fileN=[]
  for File in files:
    if os.path.isdir(File) and not os.path.islink(File):
      folderN.append(File+"/")
    else:
      fileN.append(File)

  return sorted(folderN)+sorted(fileN)

def filelister(startpath):
  #Path variables
  path=startpath
  os.chdir(path)
  path=os.getcwd()
  if path[-1]!='/':
    path+='/'
  files=listdir()
  allfiles=[]

  #Go through every file in directory
  for File in files:
    if ("proc" in File):
      continue
    k = 0
    while (k < len(File)):
      if (File[k] == "'"):
        File = File[:k] + "\\" + File[k:]
        k += 1
      k += 1
    if File[-1]=="/":
      print("'"+path+File+"'")
      allfiles=allfiles+filelister(path+File)
    else:
      allfiles.append("'"+path+"%s'"%(File))
  return allfiles

def filetimewriter(files):
  import os
  os.chdir(startlocation)
  # Variable for writing file dates in the csv file
  with open("filedata.csv", "w") as dataWriter:
    dataWriter.write("FileName"+","+"Date changed"+","+"Date Modified"+","+"\n")

    for File in files:
      try:
        output=subprocess.check_output("stat -c %z "+File, shell=True).decode().split()
        output2 = subprocess.check_output("stat -c %y "+File, shell=True).decode().split()
        #Make text to write in file, good format
        writee=File+','+output[0]+' '+output[2]+','+output2[0]+' '+output2[2]+','+'\n'
        print(writee)
        if writee[:2]=="''":
          writee=writee[2:]
        nWritee=''
        for char in writee:
          nWritee+=char
          if "''/" in nWritee:
            nWritee=nWritee[:-3]

        dataWriter.write(nWritee)
      except:
        pass

global startlocation
startlocation = os.getcwd()

allfiles = filelister("/")
filetimewriter(allfiles)

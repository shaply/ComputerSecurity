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
    if File[-1]=="/":
      print("'"+path+File+"'")
      allfiles=allfiles+filelister(path+File)
    else:
      allfiles.append("'"+path+f"{File}'")
  return allfiles

def filetimewriter(files):
  # Variable for writing file dates in the csv file
  dataWriter = open("filedata.txt", "w")
  dataWriter.write("FileName"+","+"Date changed"+","+"Date Modified"+","+"\n")

  for File in files:
    output=subprocess.check_output(f"stat -c %z {File}", shell=True).decode()
    output2 = subprocess.check_output(f"stat -c %y {File}", shell=True).decode()
    #Make text to write in file, good format
    writee=File+','+output[:-1]+','+output2[:-1]+','+'\n'
    writee=writee[2:]
    nWritee=''
    for char in writee:
      nWritee+=char
      if "''/" in nWritee:
        nWritee=nWritee[:-3]

    dataWriter.write(nWritee)

  dataWriter.close()

allfiles = filetimewriter(filelister("/"))

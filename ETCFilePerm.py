import os
import subprocess
import sys
sys.setrecursionlimit(2000)
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
  for File in files:
    if File[-1]=="/":
      print("'"+path+File+"'")
      allfiles=allfiles+filelister(path+File)
    else:
      allfiles.append("'"+path+"%s'"%(File))
  return allfiles
def filetimewriter(files):
  import os
  os.chdir(startlocation)
  with open("permissionsInETC.txt", "w") as dataWriter:
    dataWriter.write("File Name"+","+"Permissions"+","+"Owner"+","+"Group"+","+"\n")
    for File in files:
      output=subprocess.check_output("ls -list "+File, shell=True).decode().split()
      writee=File+','+output[2]+','+output[4]+','+output[5]+','+'\n'
      if output[2][5] != "-" or output[2][6] != "-" or output[2][8] != "-" or output[2][9] != "-" or output[4] != "root" or output[5] != "root":
        print(writee)
      if writee[:2]=="''":
        writee=writee[2:]
      nWritee=''
      for char in writee:
        nWritee+=char
        if "''/" in nWritee:
          nWritee=nWritee[:-3]
      dataWriter.write(nWritee)
global startlocation
startlocation = os.getcwd()
allfiles = filelister("/etc/")
filetimewriter(allfiles)

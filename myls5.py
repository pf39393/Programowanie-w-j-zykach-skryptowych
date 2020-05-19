#!/usr/bin/env python3

import sys
import pathlib
import glob
import os
import time
import pwd

def rwx(mask):
	if mask == "7":
		return "rwx"
	elif mask == "6":
		return "rw-"
	elif mask == "5":
		return "r-x"
	elif mask == "4":
		return "r--"
	elif mask == "3":
		return "-wx"
	elif mask == "2":
		return "-w-"
	elif mask == "1":
		return "--x"
	else:
		return "---"


dirname = str(pathlib.Path().absolute())
dirset = False
lopt = False;
Lopt = False;

for i in range(1,len(sys.argv)):
	if sys.argv[i] == "-l" and lopt == False:
		lopt = True
	
	elif sys.argv[i] == "-L" and Lopt == False:
		Lopt = True
		
	elif dirset == False:
		dirname = sys.argv[i]
		
	else:
		print("Nieprawidlowe argumenty wywolania funkcji")
		sys.exit()
		
paths = glob.glob(dirname + "/*")

for path in paths:
	elements = path.split("/")
	name = elements[len(elements)-1]
	line = "" + name
	
	if lopt == True:
		for i in range(len(line), 30):
			line += "-"
		line += " "
		
		size = os.path.getsize(path)
		line += str(size)
		for i in range(len(line), 40):
			line += "-"
			
		date = os.path.getmtime(path)
		date = time.ctime(date)
		line += str(date)
		line += " "
		
		if os.path.isdir(path) == True:
			line+="d"
		else:
			line+="-"
		permission = oct(os.stat(path).st_mode)[-3:]
		line+=rwx(permission[0])
		line+=rwx(permission[1])
		line+=rwx(permission[2])
		
	if Lopt == True:
		if lopt == False:
			for i in range(len(line), 30):
				line += "-"
			line += " "
		else:
			line += " "
		
		owner=pwd.getpwuid(os.stat(path).st_uid).pw_name
		line+=owner 
			
	print line
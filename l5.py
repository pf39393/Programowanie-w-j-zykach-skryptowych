#!/usr/bin/env python3

import sys
import os
import pathlib
import glob

filepaths = []

def checkdir(path):
	for path in glob.glob(path + "/*"):
		if os.path.isdir(path) == True:
			checkdir(path)
		if os.path.isfile(path) == True:
			filepaths.append([path,False])
	
def comparefiles(path1, path2):
	size1 = os.path.getsize(path1)
	size2 = os.path.getsize(path2)
	if size1 == size2:
		f1 = open(path1,'r')
		f2 = open(path2,'r')
		c1 = f1.read()
		c2 = f2.read()
		if c1 == c2:
			return True
	return False
	
if len(sys.argv) <= 1:
	print ("Podaj nazwy katalogow jako argumenty wywolania programu")
	sys.exit()

workspacepath = str(pathlib.Path().absolute()) + "/"
dirpaths = []
for i in range(1,len(sys.argv)):
	if ':/' in sys.argv[i]:
		dirpaths.append(sys.argv[i])
	else:
		dirpaths.append(workspacepath + sys.argv[i])

for path in dirpaths:
	if os.path.isdir(path) == False:
		print("Argumentami moga byc tylko nazwy folderow!")
		exit();
		
for path in dirpaths:
	checkdir(path)
	
for p in range(0,len(filepaths)):
	duplicates = []
	duplicates.append(filepaths[p][0])
	for q in range(p+1,len(filepaths)):
		if filepaths[q][1] == False and comparefiles(filepaths[p][0],filepaths[q][0]) == True:
			duplicates.append(filepaths[q][0])
			filepaths[q][1] = True
	
	if len(duplicates) > 1:
		print("#find duplicatetes:")
		for duplicate in duplicates:
			print(duplicate)
		print("")
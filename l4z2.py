#!/usr/bin/env python3

import sys
import operator

if len(sys.argv) <= 1:
	print ("Podaj nazwe pliku jako argument wywolania programu")
	sys.exit()

print (sys.argv[1])
f = open(sys.argv[1],'r')

a = []
for x in range(26):
	c = f.read(1)
	a.append(c)

d = {
	"A" : 0,
	"B" : 0,
	"C" : 0,
	"D" : 0,
	"E" : 0,
	"F" : 0,
	"G" : 0,
	"H" : 0,
	"I" : 0,
	"J" : 0,
	"K" : 0,
	"L" : 0,
	"M" : 0,
	"N" : 0,
	"O" : 0,
	"P" : 0,
	"Q" : 0,
	"R" : 0,
	"S" : 0,
	"T" : 0,
	"U" : 0,
	"V" : 0,
	"W" : 0,
	"X" : 0,
	"Y" : 0,
	"Z" : 0,
}

txt=""
while True:
	c = f.read(1)
	if not c:
		break
	
	c = c.upper()
	if c in d:
		d[c] = d[c] +1
	txt = txt + c

d = sorted(d.items(), key=operator.itemgetter(1))
d.reverse()

txtd = ""
for j in txt:
	set = 0
	for i in range(26):
		if j == a[i]:
			txtd = txtd + d[i][0]
			set = 1
	if set == 0:
		txtd = txtd + j

print(txtd)
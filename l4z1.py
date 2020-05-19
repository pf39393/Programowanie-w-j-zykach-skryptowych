#!/usr/bin/env python3

import sys
import operator

if len(sys.argv) <= 1:
	print ("Podaj nazwe pliku jako argument wywolania programu")
	sys.exit()

print (sys.argv[1])
f = open(sys.argv[1],'r')

i = 0;

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

while True:
	c = f.read(1)
	if not c:
		break
	
	c = c.upper()
	if c in d:
		d[c] = d[c] +1
	i = i + 1

d = sorted(d.items(), key=operator.itemgetter(1))
d.reverse()

for x in d:
	f = 0.0 + float(x[1])/ float(i)
	f = f * 100.0
	s="" + x[0] + " " + str(x[1]) + " " + "%.2f" % f + "%"
	print s
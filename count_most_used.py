f = open("hist","r", encoding="utf8")
t = []
lines = f.read().split("\n")

for line in lines:
	p = line.find(" ")
	t.append(line[:p])

le = len(t)
st = list(set(t))
ss = []
for i in st:
	ss.append([t.count(i), str(i)])

ss.sort()
for i in ss:
	print(i)

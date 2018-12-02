import numpy as np
import scipy.io as scio

def find_max(M): #monte carlo simulation
	N = int(1e5)
	avg = 0.0;
	for i in range(1, N):
		x = np.random.randn(M,1)
		x = np.absolute(x)
		max_val = np.amax(x)
		avg += max_val
	avg = avg / float(N)
	return avg


ms = [1];
m = 1
i = 1
while m < 1e6: #generate the list of m to test
	type = i%3;
	if type == 1:
		m *=2
	if type == 2:
		m*=2.5
	if type == 0:
		m*=2
	i += 1
	ms.append(m)
ms = map(int, ms)
Zm = []
for m in ms:
	Zm.append(find_max(m))
print(Zm)
mZm = np.vstack([ms,Zm])
np.savetxt('Zm.csv',mZm,delimiter=',')
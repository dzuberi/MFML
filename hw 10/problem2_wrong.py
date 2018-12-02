import numpy as np
import scipy.io as scio

x = np.random.random(10)
#print(x)
#print(x.transpose())
mat = scio.loadmat('hw10p2data.mat')
#a = mat['a']
X = mat.get('X')
#print(type(X))
rows = np.shape(X)[0]
col = np.shape(X)[1]
sig = np.zeros((rows,rows))
for n in range(0,col):
	sig = np.add( sig , np.outer(X[:,n],X[:,n]) )
sig /= col
max_S = np.linalg.inv(sig)
max_S[0, 3:6] = 0
max_S[1, 3:6] = 0
max_S[2, 4:6] = 0
max_S[3:6, 0] = 0
max_S[3:6, 1] = 0
max_S[4:6, 2] = 0
R = np.linalg.inv(max_S)
np.savetxt('p2_results.csv',R,delimiter=',',newline=';\n')
np.savetxt('p2_S.csv',max_S,delimiter=',',newline=';\n')
np.set_printoptions(suppress=True)
print(R)
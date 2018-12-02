import numpy as np
import scipy.io as scio
import matplotlib.pyplot as plt
from scipy.stats import norm

def Norm(x,mu,R):
	x.shape = [2,1]
	prob = 1 / (2*np.pi*np.linalg.det(R)) * np.exp(- 0.5 * np.matmul(np.transpose(x - mu),np.matmul(np.linalg.inv(R),(x-mu)) ))
	return prob

def contour(X,Y,mu,R):
	Zmap = np.zeros(np.shape(X))
	for i in range(0,np.shape(Zmap)[0]):
		for j in range(0,np.shape(Zmap)[1]):
			this_point = np.array([X[i,j],Y[i,j]])
			this_point.shape = [2,1]
			Zmap[i,j] = Norm(this_point,mu,R)
	return Zmap
mat = scio.loadmat('hw10p5data.mat')
X = mat.get('X')
x_raw = X[0,:]
y_raw = X[1,:]
xn = []
for i in range(0,np.shape(X)[1]):
	xn.append(X[:,i])
	xn[i].shape = [2,1]
plt.scatter(x_raw,y_raw)
min_x = np.amin(x_raw)
max_x = np.amax(x_raw)
min_y = np.amin(y_raw)
max_y = np.amax(y_raw)
x = np.linspace(min_x*1.1,max_x*1.1,100)
y = np.linspace(min_y*1.1,max_y*1.1,100)
X,Y = np.meshgrid(x,y)
mus = [np.array([-0.9,0.1]),np.array([-0.5,0.07]),np.array([0.02,0]),np.array([0.6,-0.03]),np.array([0.92,-0.06])]
for i in range(0,len(mus)):
	mus[i].shape = [2,1]
I = np.identity(2)
sigmas = [0.05*I,0.2*I,0.3*I,0.1*I,0.1*I]
betas = [0.1,0.1,0.1,0.1,0.1]
K = 200
Q = len(mus)
N = len(xn)

for k in range(0,K):
	gamma = np.zeros([N,Q])
	for n in range(0,N):
		for q in range(0,Q):
			denom = 0
			for q_ in range(0,Q):
				denom += betas[q_] * Norm(xn[n],mus[q_],sigmas[q_])
			gamma[n,q] = betas[q]*Norm(xn[n],mus[q],sigmas[q]) / denom
	sum_gam = np.sum(gamma,0)
	betas = sum_gam / N
	temp_mus = []
	for q in range(0,Q):
		mu_q = 0
		for n in range(0,N):
			mu_q += gamma[n,q]*xn[n]
		temp_mus.append(mu_q / sum_gam[q])
	mus = temp_mus
	temp_sigs = []
	for q in range(0,Q):
		numer = 0
		for n in range(0,N):
			numer += gamma[n,q]*np.matmul((xn[n]- mus[q]),np.transpose(xn[n] - mus[q]))
		temp_sigs.append(numer / sum_gam[q])
	sigmas = temp_sigs

for q in range(0,Q):
	Zmap = contour(X,Y,mus[q],sigmas[q])
	plt.contour(X,Y,Zmap)
plt.title('EM Algoritm for ' + str(K) + ' iterations')
plt.xlabel('x[1]')
plt.ylabel('x[2]')
plt.show()
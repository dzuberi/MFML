import numpy as np
import scipy.stats as stat
import matplotlib.pyplot as plt

def gen_y(p):
	x = np.random.uniform(0,1)
	if x < p:
		return 0
	return 1

def gen_x(y):
	x = np.random.randn();
	if y == 0:
		x = -1 + 2*x
	else:
		x = 1 + 2*x
	return(x)

def R_h(theta,p):
	R = np.zeros(np.shape(theta))
	for idx,t in enumerate(theta):
		R[idx] = (1 - p)*stat.norm.cdf((t - 1) / 2) + p*(1-stat.norm.cdf((t + 1) / 2))
	return R

def find_nearest(array,value):
	idx = (np.abs(array - value)).argmin()
	return idx

N = 1e3
Ns = [10,100,1000]
R_minus_Rhat_08 = np.zeros(np.shape(Ns))
R_minus_Rhat_max = np.zeros(np.shape(Ns))
for idx,N in enumerate(Ns):
	plt.subplot(3,1,idx+1)
	theta = np.linspace(-10,10,int(1e3))
	loss = np.zeros(np.shape(theta))
	for n in range(1,int(N)):
		y = gen_y(0.4)
		x = gen_x(y)
		h_theta = np.zeros(np.shape(theta))
		l = np.zeros(np.shape(theta))
		for index,t in enumerate(theta):
			if x < t:
				h_theta[index] = 0
			else:
				h_theta[index] = 1
		for index,h in enumerate(h_theta):
			if h == y:
				l[index] = 0
			else:
				l[index] = 1
		loss = np.add(loss,l)
	loss /= N
	Rhat = loss
	R = R_h(theta,0.4)
	plt.plot(theta,Rhat)
	plt.plot(theta,R)
	plt.title("R and Rhat for N = " + str(int(N)))
	plt.xlabel("theta")
	plt.ylabel("R,Rhat")
	i = find_nearest(theta,0.8)
	R_minus_Rhat = np.abs(np.subtract(R,Rhat))
	R_minus_Rhat_08[idx] =  R_minus_Rhat[i]
	R_minus_Rhat_max[idx] = np.amax(R_minus_Rhat)
print(R_minus_Rhat_08)
print(R_minus_Rhat_max) 
print(np.amin(R))
plt.show()
import numpy as np 
import scipy.io as scio

def inv(A):
	return np.linalg.inv(A)

def get_sigma():
	mat = scio.loadmat('hw10p2data.mat')
	X = mat.get('X')
	rows = np.shape(X)[0]
	col = np.shape(X)[1]
	sig = np.zeros((rows,rows))
	for n in range(0,col):
		sig = np.add( sig , np.outer(X[:,n],X[:,n]) )
	sig /= col
	return sig

sigma = get_sigma()

def Ps(A): #set the appropriate values to zero
	A[0, 3:6] = 0
	A[1, 3:6] = 0
	A[2, 4:6] = 0
	A[3:6, 0] = 0
	A[3:6, 1] = 0
	A[4:6, 2] = 0
	return A

def grad(S): #Find the gradient for a given S
	return sigma - inv(S)


def in_S(S): #check if matrix satisfies our condition, 
#give 1e-12 tolerance for inversion errors
	if np.any(S[0,3:6] > 1e-10):
		return 0
	elif np.any(S[1,3:6] > 1e-12):
		return 0
	elif np.any(S[2,4:6] > 1e-12):
		return 0
	elif np.any(S[3:6,0] > 1e-12):
		return 0
	elif np.any(S[3:6,1] > 1e-12):
		return 0
	elif np.any(S[4:6,2] > 1e-12):
		return 0
	else:
	 	return 1

def alpha_search(S,g): #search for a high alpha that keeps the result in our set,
#reduce by 90% per iteration
	alpha = 1.0
	while(in_S(S - alpha*g) == 0):
		alpha *= 0.9
	return alpha

S= np.identity(6)
for k in range(0,int(1e4)):
	g = Ps(grad(S))
	a = alpha_search(S, g)
	S = S - a*g
	S = Ps(S)
R = inv(S)
np.set_printoptions(suppress=True)
print('Result:')
print(R)
print('Sample Cov:')
print(sigma)
np.savetxt('p2_R.txt',inv(S),delimiter=' ',newline='\n')
np.savetxt('p2_invR.txt',S,delimiter=' ',newline='\n')
#Result:
#[[ 0.16251014 -0.01555197  0.00967764 -0.00177352 -0.00010501  0.0001178 ]
# [-0.01555197  0.13665699  0.00023067 -0.00004227 -0.0000025   0.00000281]
# [ 0.00967764  0.00023067  0.12290445 -0.02252338 -0.00133363  0.00149608]
# [-0.00177352 -0.00004227 -0.02252338  0.14042444  0.00831469 -0.00932746]
# [-0.00010501 -0.0000025  -0.00133363  0.00831469  0.13024438  0.01727435]
# [ 0.0001178   0.00000281  0.00149608 -0.00932746  0.01727435  0.12111833]]
#Sample Cov:
#[[ 0.16251014 -0.01555197  0.00967764  0.00416033  0.00268576  0.00845445]
# [-0.01555197  0.13665699  0.00023067 -0.0084813  -0.00617924  0.00694164]
# [ 0.00967764  0.00023067  0.12290445 -0.02252338 -0.00195947  0.00093073]
# [ 0.00416033 -0.0084813  -0.02252338  0.14042444  0.00831469 -0.00932746]
# [ 0.00268576 -0.00617924 -0.00195947  0.00831469  0.13024438  0.01727435]
#The sample covariance and output look quite similar. The biggest differences are in the
#entries of the conditionally independent entries.
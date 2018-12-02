import matplotlib.pyplot as plt
import numpy as np

mZm = np.genfromtxt('Zm.csv',delimiter=',')
m = mZm[0,:]
Zm = mZm[1,:]
plt.semilogx(m,Zm)
plt.title('m vs Z_m')
plt.xlabel('m')
plt.ylabel('Z_m')


plt.show()

# coding: utf-8

# In[376]:

import pyspark
sc = pyspark.SparkContext('local[*]')


# In[439]:

from numpy import *


# In[495]:

x = 2*numpy.random.random(size=(10,2))-1
b = numpy.random.random(size=(2,1))
y = x.dot(b) + .3*numpy.random.random(size=(10,1))


# In[453]:

px1 = np.linspace(-2,2,401)
px2 = np.linspace(-2,2,401)


# In[496]:

[PX1,PX2] = np.meshgrid(px1,px2)


# In[497]:

PY = [[] for i in range(10)]
TPY = np.zeros(size(401*401))


# In[456]:

for i in range(10):
    x1 = np.add(y[i], -x[i][0]*PX1)
    x2 = np.add(x1, -x[i][1]*PX2)
    PY[i] = x2**2
    #PY[i]=(y[i]-x[i][0]*PX1-x[i][1]*PX2)**2
    #TPY = TPY+PY[i];
    TPY = np.add(TPY, PY[i])


# In[457]:

from matplotlib.pyplot import *


# In[458]:

TTPY = np.zeros(size(401*401))


# In[459]:

for i in range(10):
    TTPY = np.add(TTPY, PY[i])
    #contour(PX1, PX2, exp(-PY[i]),linewidth=2)
    #contour(PX1, PX2, exp(-TTPY),linewidth=2)
    #contour(PX1, PX2, exp(-TPY),colors='blue', linewidth=2)
    #clabel(C, inline=1, fontsize=10)
    #show()
contour(PX1, PX2, exp(-TTPY),linewidth=2)
show()


# In[460]:

points = np.zeros((2, 100))
eta = 0.1


# In[461]:

import matplotlib.pyplot as plt


# In[499]:

for i in range(99):
    id = numpy.random.randint(0,9)
    tx = x[id]
    ty = y[id]
    tx.shape = (1,2)
    tx1 = transpose(tx)
    y1 = np.dot(tx1,tx)
    y2 = np.dot(y1,points[:,i])
    grad = 2*(y2-(ty*tx1).flatten())
    points[:,i+1] = points[:,i] - eta*grad.T


# In[500]:

points


# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




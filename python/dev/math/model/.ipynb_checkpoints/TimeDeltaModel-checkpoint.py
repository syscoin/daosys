import numpy as np

class TimeDeltaModel():             

    def apply(self, p = 0.00001):  
        return np.random.negative_binomial(1, p)          
 
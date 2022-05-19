import numpy as np

class TimeDeltaModel():             

    def apply(self, n = 1, p = 0.00001):  
        if(n == 1):
            return np.random.negative_binomial(1, p)  
        else:
            
            res = []
            for k in range(n):
                rval = np.random.negative_binomial(1, p)
                res.append(rval)
                
            return res              

            
 
import numpy as np
    
class TokenDeltaModel():
    
    def __init__(self, shape=1, scale=1):
        self.__shape = shape
        self.__scale = scale

    def apply(self, n = 1, max_trade = 10000):
        
        if(n == 1):
            delta = np.random.gamma(self.__shape, self.__scale)
            return min(delta, max_trade)  
        else:
    
            res = []
            for k in range(n):
                rval = np.random.gamma(self.__shape, self.__scale)
                res.append(min(rval,max_trade))
                
            return res        
     
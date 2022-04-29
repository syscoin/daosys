import numpy as np
    
class TokenDeltaModel():
    
    def __init__(self, shape=1, scale=1):
        self.__shape = shape
        self.__scale = scale

    def apply(self, max_trade = 10000):  
        delta = np.random.gamma(self.__shape, self.__scale)
        return min(delta, max_trade)     
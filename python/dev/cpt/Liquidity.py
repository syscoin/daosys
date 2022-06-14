# Based on Uniswap v1 and v2 (see Reference 1); for Uniswap v3 see reference 2

# References: 

# [1] Pandichef, A Brief History of Uniswap and Its Math 
# Link: https://pandichef.medium.com/a-brief-history-of-uniswap-and-its-math-90443241c9b7

# [2] Atis Elsts, Liquidity Math in Uniswap V3  
# Link: https://atiselsts.github.io/pdfs/uniswap-v3-liquidity-math.pdf

import numpy as np
import copy

class Liquidity():
    
    YX_PRICE = 'YX'
    XY_PRICE = 'XY'
    
    def __init__(self, x_real, y_real, x_name, y_name):
        self.__x_real = x_real
        self.__y_real = y_real  
        self.__liquidity_val = 0
        self.__yx_swap_price = None 
        self.__x_name = x_name
        self.__y_name = y_name          
          
    def get_x_real(self):
        return self.__x_real

    def get_y_real(self):
        return self.__y_real
    
    def get_x_name(self):
        return self.__x_name  
    
    def get_y_name(self):
        return self.__y_name      
    
    def get_liquidity_val(self):
        return self.__liquidity_val  
      
    def get_swap_price(self, direction = 'YX'): 
        if direction == self.YX_PRICE:
            return self.__yx_swap_price
        else: 
            return 1/self.__yx_swap_price    
          
    def set_y_real(self, y_real):
        self.__y_real = y_real
        
    def set_x_real(self, x_real):
        self.__x_real = x_real
        
    def set_x_name(self, x_name):
        self.__x_name = x_name  
    
    def set_y_name(self, y_name):
        self.__y_name = y_name   
        
    def delta_x(self, x_new):
        self.__x_real = self.__x_real + x_new  
        
      
    def delta_y(self, y_new):
        self.__y_real = self.__y_real + y_new       
        
    def calc_delta_y(self, delta_x):
        return (self.__y_real*delta_x)/(self.__x_real+delta_x)

    def calc_delta_x(self, delta_y):
        return (self.__x_real*delta_y)/(self.__y_real+delta_y)

    def calc(self): 
        
        self.__prev_liquidity_val = copy.copy(self.__liquidity_val)
        if(self.__x_real != 0):
            self.__yx_swap_price = self.__y_real / self.__x_real
            self.__liquidity_val = np.sqrt(self.__x_real*self.__y_real)

        return self.__liquidity_val
         
    def swap(self, delta_x):
        
        delta_y = self.calc_delta_y(delta_x)
        self.__swap_price = delta_y / delta_x
        self.__x_real = (self.__x_real+delta_x)
        self.__y_real = (self.__y_real-delta_y)      
         
        return np.sqrt(self.__x_real*self.__y_real)
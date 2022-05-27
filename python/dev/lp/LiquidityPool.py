from python.dev.cpt import Liquidity

class LiquidityPool():

    def __init__(self, name, user):
        self.__name = name
        self.__user = user
        self.__liquidity = Liquidity(0,0)
  
    def update_event(self, lp_event):
        lp_event.update(self.__liquidity)

    def get_name(self):
        return self.__name   
    
    def get_user(self):
        return self.__user       
        
    def get_liquidity(self):
        return self.__liquidity 
    
    def get_liquidity_val(self):
        return self.__liquidity.calc()     
   
    def get_price(self):
        return self.__liquidity.get_swap_price()

    def get_x(self):
        return self.__liquidity.get_x_real()    
   
    def get_y(self):
        return self.__liquidity.get_y_real()
   

    
        
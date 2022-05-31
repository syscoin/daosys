from python.dev.cpt import Liquidity
from python.dev.lp.event.series import LPEventSeries

class LiquidityPool():

    def __init__(self, name, user, x_token = None, y_token = None):
        self.__name = name
        self.__user = user
        self.__x_token = x_token
        self.__y_token = y_token
        self.__liquidity = Liquidity(0,0)
        self.__liquidity_val = 0
        self.__lp_events = LPEventSeries(name)
  
    def update_event(self, lp_event):
        self.__liquidity_val = lp_event.update(self.__liquidity)
        self.__lp_events.add_event(lp_event)
           
    def get_lp_events(self):
        return self.__lp_events

    def get_name(self):
        return self.__name   
    
    def get_user(self):
        return self.__user      
    
    def get_x_token(self):
        return self.__x_token   
    
    def get_y_token(self):
        return self.__y_token      
        
    def get_liquidity(self):
        return self.__liquidity 
    
    def get_liquidity_val(self):
        return self.__liquidity_val     
   
    def get_price(self):
        return self.__liquidity.get_swap_price()

    def get_x(self):
        return self.__liquidity.get_x_real()    
   
    def get_y(self):
        return self.__liquidity.get_y_real()
   

    
        
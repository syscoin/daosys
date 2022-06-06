from python.dev.cpt import Liquidity
from python.dev.lp.event.series import LPEventSeries

class LiquidityPool():

    def __init__(self, lp_name, user, x_target = None, y_target = None):
        self.__lp_name = lp_name
        self.__user = user
        self.__x_target = x_target
        self.__y_target = y_target
        self.__liquidity = Liquidity(0,0)
        self.__liquidity_val = 0
        self.__lp_events = LPEventSeries(lp_name)
  
    def update_event(self, lp_event):        
        self.__liquidity_val = lp_event.update(self.__liquidity)
        self.__lp_events.add_event(lp_event)
  
    def get_lp_events(self):
        return self.__lp_events

    def get_name(self):
        return self.__lp_name   
    
    def get_user(self):
        return self.__user      
    
    def get_x_target(self):
        return self.__x_target   
    
    def get_y_target(self):
        return self.__y_target      
        
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
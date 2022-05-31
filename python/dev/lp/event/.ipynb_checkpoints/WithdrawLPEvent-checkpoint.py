from python.dev.lp.event import LPEvent
import copy

class WithdrawLPEvent(LPEvent):

     
    def __init__(self, withdraw_action):
        self.__withdraw_action = withdraw_action
        self.__liquidity = None

    def update(self, liquidity):
        pass
    
    def set_liquidity(self, liquidity):
        self.__liquidity = copy.copy(liquidity)
        
    def get_liquidity(self):
        return self.__liquidity        
    
    def get_action(self):
        return self.__withdraw_action      
    
    def get_type(self):
        return LPEvent.EVENT_LP_WITHDRAW     
   
    
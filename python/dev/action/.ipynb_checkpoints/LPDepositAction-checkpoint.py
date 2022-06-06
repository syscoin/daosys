from python.dev.action import DepositAction
from python.dev.event import Deposit
import copy

class LPDepositAction(DepositAction):
    
    def __init__(self, token_event, target, user, mint_id = None):
        super().__init__(token_event, target, user, mint_id)
        self.__x_target = target.get_x_target()
        self.__y_target = target.get_y_target()
        self.__prev_liquidity_val = 0
 
    def get_prev_liquidity(self):
        return self.__prev_liquidity_val

    def set_prev_liquidity(self, prev_liquidity):
        self.__prev_liquidity_val = copy.copy(prev_liquidity)

    def apply(self, agents):
        
        mint_id = super().get_mint_id()   
        token = super().get_target().get_token()        
        address = super().get_target().get_address(mint_id) 
        token_index = super().get_target().get_token_index(address)
        apy = super().get_event().get_apy()
        t_delta = super().get_event().get_time_delta()
        delta = self.__calc_delta(token_index)
        event = Deposit(apy, delta, t_delta, address)
        token.add_event(event)                
        
        super().get_target().set_token(token) 
        super().get_target().update_token_index(address)
        
        return True
    
    
    def __calc_delta(self, token_index):
            
        lp_events = super().get_target().get_lp().get_lp_events()    
        liq_val = lp_events.get_event(-1).get_liquidity().get_liquidity_val()
      
        if (token_index == 0):
            delta = liq_val
        else:
            prev_liq_val = super().get_target().get_lp_val()
            delta = liq_val - prev_liq_val

        super().get_target().set_lp_val(liq_val)    
           
        return delta

            
    

    
        
from python.dev.action import DepositAction
from python.dev.action import Action
from python.dev.event import Deposit
from python.dev.event import TokenEvent
from python.dev.lp.event import DepositLPEvent
import numpy as np
import copy

class LPDepositChainAction(Action):
    
    def __init__(self, action1, action2, target, user, mint_id = None):
        self.__action1 = action1
        self.__action2 = action2
        self.__target = target
        self.__user = user
        self.__mint_id = mint_id        
        self.__x_target = target.get_x_target()
        self.__y_target = target.get_y_target()
        self.__prev_liquidity_val = 0
 
    def get_prev_liquidity(self):
        return self.__prev_liquidity_val

    def set_prev_liquidity(self, prev_liquidity):
        self.__prev_liquidity_val = copy.copy(prev_liquidity)
        
    def get_mint_id(self):
        return self.__mint_id  

    def get_event(self, action = None):     
        action = self.__action1 if action == None else action
        return action.get_event()

    def get_user(self):
        return self.__user
    
    def get_target(self):
        return self.__target    
        
    def get_type(self):
        return TokenEvent.EVENT_DEPOSIT      

    def apply(self, agents):
        
        mint_id = self.get_mint_id()   
        token = self.get_target().get_token()        
        address = self.get_target().get_address(mint_id) 
        token_index = self.get_target().get_token_index(address)
        
        apy = self.get_event(self.__action1).get_apy()  
        
        t_delta1 = self.get_event(self.__action1).get_time_delta()
        t_delta2 = self.get_event(self.__action2).get_time_delta()
        
        t_delta = max(t_delta1, t_delta2)
        
        delta1 = abs(self.get_event(self.__action1).get_delta())   
        delta2 = abs(self.get_event(self.__action2).get_delta()) 
        
        lp_delta = self.__calc_delta(token_index, delta1, delta2)
        
        event = Deposit(apy, lp_delta, t_delta, address)
        
        self.__update_lp(event)
        token.add_event(event)                
        
        self.get_target().set_token(token) 
        self.get_target().update_token_index(address)
        
        return True
    
    
    def __update_lp(self, event):
        
        lp = self.get_target().get_lp()
        target = self.__target
        user = self.__user
        mint_id = self.__mint_id
        action = DepositAction(event, target, user, mint_id)    
        lp.update_event(DepositLPEvent(action))

    def __calc_delta(self, index, delta1, delta2):
            
        lp_events = self.get_target().get_lp().get_lp_events()
        lp = self.get_target().get_lp()
        lp.get_liquidity().delta_x(delta1)
        lp.get_liquidity().delta_y(delta2)        
        
        if(index == 0):
            delta = np.sqrt(delta1*delta2)
        else:
                
            reserve1 = lp_events.get_event(-1).get_liquidity().get_x_real()
            reserve2 = lp_events.get_event(-1).get_liquidity().get_y_real()
            liq_val = lp_events.get_event(-1).get_liquidity().get_liquidity_val()
            
            liq1 = delta1*liq_val/reserve1
            liq2 = delta2*liq_val/reserve2
            
            delta = min(liq1,liq2)
                               
        return delta        
        
        
    def __calc_delta2(self, token_index):
            
        lp_events = self.get_target().get_lp().get_lp_events()    
        liq_val = lp_events.get_event(-1).get_liquidity().get_liquidity_val()
        
        if (token_index == 0):
            delta = liq_val
        else:
            prev_liq_val = self.get_target().get_lp_val()
            delta = liq_val - prev_liq_val

        self.get_target().set_lp_val(liq_val)    
           
        return delta

            
    

    
        